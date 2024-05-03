#!/usr/bin/env python3

import json
import re
import os

import os

CRATE_ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")

ADA_KEYWORD = ["end", "type", "body", "out"]

TYPE_CONVERSION = {
    "void": None,
    "char": "Interfaces.C.char",
    "bool": "Interfaces.C.C_bool",
    "float": "Interfaces.C.C_float",
    "double": "Interfaces.C.double",
    "long": "Interfaces.C.long",
    "float *": "access Interfaces.C.C_float",
    "float*": "access Interfaces.C.C_float",
    "int": "Interfaces.C.int",
    "int *": "access Interfaces.C.int",
    "const int *": "access constant Interfaces.C.int",
    "char *": "Interfaces.C.Strings.chars_ptr",
    "const char *": "Interfaces.C.Strings.chars_ptr",
    "unsigned int": "Interfaces.C.unsigned",
    "unsigned int *": "access Interfaces.C.unsigned",
    "unsigned char": "Interfaces.C.unsigned_char",
    "unsigned char *": "access Interfaces.C.char",
    "unsigned short": "Interfaces.C.short",
    "unsigned short *": "access Interfaces.C.short",
    "void *": "System.Address",
    "const void *": "System.Address",
    "const unsigned char *": "System.Address",
    "const cpVect": "cpVect",
}

TYPE_IDENTITY = [
    "cpVect",
    "cpFloat",
    "cpShape",
    "cpBool",
    "cpBB",
    "cpTransform",
    "cpBodyType",
    "cpDataPointer",
    "cpContactPointSet",
    "cpSpaceDebugColor",
    "cpSpaceDebugDrawFlags",
    "cpTimestamp",
    "cpCollisionHandler",
    "cpCollisionType",
    "cpShapeFilter",
    "cpGroup",
    "cpBitmask",
]

for typ in [
    "cpBody",
    "cpArbiter",
    "cpSpace",
    "cpShape",
    "cpCircleShape",
    "cpSegmentShape",
    "cpPolyShape",
    "cpConstraint",
    "cpPivotJoint",
    "cpPinJoint",
    "cpGearJoint",
    "cpGrooveJoint",
    "cpSlideJoint",
    "cpSimpleMotor",
    "cpRotaryLimitJoint",
    "cpDampedRotarySpring",
    "cpDampedSpring",
    "cpPointQueryInfo",
    "cpSegmentQueryInfo",
    "cpRatchetJoint",
]:
    TYPE_CONVERSION[f"{typ}*"] = typ
    TYPE_CONVERSION[f"{typ} *"] = typ
    TYPE_CONVERSION[f"struct {typ} *"] = typ
    TYPE_CONVERSION[f"const {typ} *"] = typ


def to_ada_type(c_type, name=None, parent=None):

    if c_type == "const cpVect *" and name == "verts":
        return "access C_cpVect_Array"

    if c_type in TYPE_IDENTITY:
        return c_type
    elif c_type in TYPE_CONVERSION:
        return TYPE_CONVERSION[c_type]
    elif c_type.endswith("*"):
        return "access " + to_ada_type(c_type[:-1].strip(), name, parent)
    else:
        print(TYPE_IDENTITY)
        raise Exception(f"unknown type: '{c_type}' for {name} in {parent}")


def is_type_name(name):
    for type in TYPE_IDENTITY:
        if name.lower() == type.lower():
            return True
    for type in TYPE_CONVERSION.keys():
        if name.lower() == type.lower():
            return True
    return False


def gen_struct(struct):

    out = f"   type {struct['name']} is record\n"
    for field in struct["fields"]:
        if field["name"] == "type":
            field["name"] = "type_K"

        if is_type_name(field["name"]):
            field["name"] = field["name"] + "_f"
        desc = field["description"].strip()
        desc = f" -- {desc}" if desc != "" else ""
        out += f"      {field['name']} : {to_ada_type(field['type'], field['name'], struct['name'])};{desc}\n"
    out += "   end record\n"
    out += "      with Convention => C_Pass_By_Copy;\n"

    out += "\n"

    TYPE_IDENTITY.append(struct["name"])

    return out


def enum_kind(name):
    if name.endswith("Flags") or name in ["Gesture"]:
        return "unsigned_new_type"
    elif name in []:
        return "int_subtype"
    elif name in []:
        return "int_new_type"
    else:
        return "ada_enums"


def gen_enum(enum):
    out = ""
    kind = enum_kind(enum["name"])

    if kind == "unsigned_new_type":
        # The enum represents flags that can be combined, so we use a modular type
        out += f"   type {enum['name']} is new Interfaces.C.unsigned;\n"
    elif kind == "int_subtype":
        out += f"   subtype {enum['name']} is Interfaces.C.int;\n"
    elif kind == "int_new_type":
        # In these cases the enum is just used as a list of default/common
        # values for the type.
        out += f"   type {enum['name']} is new Interfaces.C.int;\n"

    if kind in ["unsigned_new_type", "int_subtype", "int_new_type"]:
        if len(enum["description"].strip()) != 0:
            out += f"   --  {enum['description']}\n"
        out += "\n"

        for value in enum["values"]:
            desc = (
                ""
                if len(value["description"].strip()) == 0
                else f" -- {value['description']}"
            )
            out += f"   {value['name']} : constant {enum['name']} := {value['value']};{desc}\n"
    else:
        # Otherwise use regular Ada enums
        out += f"   type {enum['name']} is\n"
        out += "     (\n"
        sorted_value = sorted(enum["values"], key=lambda d: d["value"])
        first = True
        for value in sorted_value:
            coma = "  " if first else ", "
            desc = (
                ""
                if len(value["description"].strip()) == 0
                else f" -- {value['description']}"
            )
            out += f"       {coma}{value['name']}{desc}\n"
            first = False
        out += "     )\n"
        out += "     with Convention => C;\n"
        if len(enum["description"].strip()) != 0:
            out += f"   --  {enum['description']}\n"
        out += "\n"

        out += f"   for {enum['name']} use\n"
        out += "     (\n"
        first = True
        for value in sorted_value:
            coma = "  " if first else ", "
            out += f"       {coma}{value['name']} => {value['value']}\n"
            first = False
        out += "     );\n"
    out += "\n"
    return out


def function_decl(function, spec=True, callback=False):
    out = ""
    param_decls = []
    if function["params"] is not None:
        for p in function["params"]:
            param_decls += [f"{p['name']} : {p['type']}"]

    if len(param_decls) != 0:
        params_str = " (" + "; ".join(param_decls) + ")"
    else:
        params_str = ""

    if callback:
        out += f"   type {function['name']} is access "
        function["name"] = ""

    term = (";" if not callback else "") if spec else " is"
    if function["returnType"] is None:
        out += f"   procedure {function['name']}{params_str}{term}\n"
    else:
        out += f"   function {function['name']}{params_str} return {function['returnType']}{term}\n"
    if spec and not callback:
        out += f"   --  {function['description']}\n"
    return out


def gen_string_function_body(function):
    out = ""
    out += function_decl(function, spec=False)
    out += "      use Interfaces.C.Strings;\n"
    params = function["params"] if function["params"] is not None else []
    ret_type = function["returnType"]
    ret_str = ret_type == "String"

    call_params = []
    for p in params:
        if p["type"] == "String":
            out += f"      C_{p['name']} : Interfaces.C.Strings.chars_ptr := New_String ({p['name']});\n"
            call_params.append(f"C_{p['name']}")
        else:
            call_params.append(p["name"])

    if len(call_params) > 0:
        call_str = f"{function['name']} ({', '.join(call_params)})"
    else:
        call_str = f"{function['name']}"

    if ret_type:
        if ret_type == "String":
            call_str = f"Value ({call_str})"
        out += f"      Result : constant {ret_type} := {call_str};\n"
    out += "   begin\n"

    if not ret_type:
        out += f"      {call_str};\n"
    for p in params:
        if p["type"] == "String":
            out += f"      Free (C_{p['name']});\n"

    if ret_type:
        out += "      return Result;\n"

    out += f"   end {function['name']};\n\n"

    return out


def process_params(params, function_name):
    C_STRING_TYPE = "Interfaces.C.Strings.chars_ptr"
    has_string = False
    for p in params:
        if p["name"] in ADA_KEYWORD or is_type_name(p["name"]):
            p["name"] = p["name"] + "_p"
        p["type"] = to_ada_type(p["type"], p["name"], function_name)
        if p["type"] == C_STRING_TYPE:
            has_string = True
    return params, has_string


def GUI_string_exception(param, function):
    """
    Return true is the parameter should not be converted to an Ada String.
    This is required for some GUI function that modify the string.
    """
    return function["name"] == "GuiTextInputBox" and param["name"] == "text"


def gen_function(function):
    spec = ""
    body = ""
    C_STRING_TYPE = "Interfaces.C.Strings.chars_ptr"

    function["returnType"] = to_ada_type(
        function["returnType"], "RETURNTYPE", function["name"]
    )

    has_string = function["returnType"] == C_STRING_TYPE
    if "params" in function:
        function["params"], has_string = process_params(
            function["params"], function["name"]
        )
    else:
        function["params"] = None

    spec += function_decl(function)
    if function["name"] == "GetColor":
        # Declare a variant of get color that will work with the output of GuiGetStyle
        spec += "   function GetColor (hexValue : Interfaces.C.int) return Color;\n"
    spec += f"   pragma Import (C, {function['name']}, \"{function['name']}\");\n\n"

    if has_string:
        # This sub-program either returns a string or takes a string argument.
        # We write wrapper version that handles conversions between C and Ada String.

        if function["returnType"] == C_STRING_TYPE:
            function["returnType"] = "String"

        if function["params"] is not None:
            for p in function["params"]:
                if p["type"] == C_STRING_TYPE and not GUI_string_exception(p, function):
                    p["type"] = "String"

        spec += function_decl(function) + "\n"
        body += gen_string_function_body(function)
    return (spec, body)


def gen_define(define):
    out = ""
    if define["type"] == "COLOR":
        r = re.compile("CLITERAL\(Color\)\{ ([0-9]+), ([0-9]+), ([0-9]+), ([0-9]+) \}")
        r, g, b, a = r.match(define["value"]).groups()
        out += f"   {define['name']} : constant Color := ({r}, {g}, {b}, {a});\n"
    elif define["type"] == "STRING":
        out += f"   {define['name']} : constant String := \"{define['value']}\";\n"
    elif define["type"] == "INT" or define["type"] == "FLOAT":
        out += f"   {define['name']} : constant := {define['value']};\n"

    return out


def gen_callback(callback):
    global TYPE_IDENTITY
    TYPE_IDENTITY.append(callback["name"])

    out = ""
    callback["returnType"] = to_ada_type(callback["returnType"], "RETURNTYPE")
    callback["params"], _ = process_params(callback["params"], callback["name"])
    out += function_decl(callback, spec=True, callback=True)
    out += "\n     with Convention => C;\n"

    if callback["description"]:
        out += f"   --  {callback['description']}\n"
    out += "\n"

    return out


def gen_binding(json_file, package_name, package_file):

    SKIP_CALLBACKS = []
    SKIP_STRUCTS = ["cpSpaceDebugColor"]
    SKIP_FUNCTIONS = []

    with open(os.path.join(CRATE_ROOT, "scripts", json_file), encoding="utf-8") as file:
        data = json.load(file)

    spec = ""
    body = ""
    body_required = False

    spec = "with Interfaces.C;\n"
    spec += "with Interfaces.C.Strings;\n"
    spec += f"package {package_name}\n"
    spec += "  with Preelaborate\n"
    spec += "is\n"
    spec += '   pragma Style_Checks ("M2000");\n'

    # Do the enums first as the contain definitions used in structs and functions
    for enum in data["enums"]:
        spec += gen_enum(enum)

    body += f"package body {package_name} is\n"

    body += '   pragma Style_Checks ("M2000");\n'

    for callback in data["callbacks"]:
        if callback["name"] not in SKIP_CALLBACKS:
            spec += gen_callback(callback)

    for struct in data["structs"]:
        if struct["name"] not in SKIP_STRUCTS:
            spec += gen_struct(struct)

    for function in data["functions"]:
        if function["name"] not in SKIP_FUNCTIONS:
            f_spec, f_body = gen_function(function)
            spec += f_spec
            if f_body != "":
                body_required = True
                body += f_body

    for define in data["defines"]:
        spec += gen_define(define)

    spec += f"end {package_name};\n"
    body += f"end {package_name};\n"

    spec_filename = os.path.join(CRATE_ROOT, "src", package_file + ".ads")
    body_filename = os.path.join(CRATE_ROOT, "src", package_file + ".adb")

    with open(spec_filename, "w", encoding="utf-8") as f:
        print(f"Writing {spec_filename}")
        f.write(spec)

    if body_required:
        with open(body_filename, "w", encoding="utf-8") as f:
            print(f"Writing {body_filename}")
            f.write(body)


# gen_binding("chipmunk_structs.h.json", "Chipmunk.Types", "chipmunk-types")
gen_binding("cpBody.h.json", "Chipmunk.Bodies", "chipmunk-bodies")
gen_binding("cpSpace.h.json", "Chipmunk.Spaces", "chipmunk-spaces")
gen_binding("cpShape.h.json", "Chipmunk.Shapes", "chipmunk-shapes")
gen_binding("cpPolyShape.h.json", "Chipmunk.PolyShapes", "chipmunk-polyshapes")
gen_binding("cpConstraint.h.json", "Chipmunk.Constraints", "chipmunk-constraints")
gen_binding(
    "cpDampedSpring.h.json", "Chipmunk.Damped_Springs", "chipmunk-damped_springs"
)
gen_binding(
    "cpDampedRotarySpring.h.json",
    "Chipmunk.Damped_Rotary_Springs",
    "chipmunk-damped_rotary_springs",
)
gen_binding(
    "cpPivotJoint.h.json",
    "Chipmunk.Pivot_Joints",
    "chipmunk-pivot_joints",
)
gen_binding(
    "cpPinJoint.h.json",
    "Chipmunk.Pin_Joints",
    "chipmunk-pin_joints",
)
gen_binding(
    "cpGearJoint.h.json",
    "Chipmunk.Gear_Joints",
    "chipmunk-gear_joints",
)
gen_binding(
    "cpGrooveJoint.h.json",
    "Chipmunk.Groove_Joints",
    "chipmunk-groove_joints",
)
gen_binding(
    "cpRatchetJoint.h.json",
    "Chipmunk.Ratchet_Joints",
    "chipmunk-ratchet_joints",
)
gen_binding(
    "cpRotaryLimitJoint.h.json",
    "Chipmunk.Rotary_Limit_Joints",
    "chipmunk-rotary_limit_joints",
)
gen_binding(
    "cpSlideJoint.h.json",
    "Chipmunk.Slide_Joints",
    "chipmunk-slide_joints",
)
gen_binding(
    "cpSimpleMotor.h.json",
    "Chipmunk.Simple_Motors",
    "chipmunk-simple_motors",
)
gen_binding(
    "cpArbiter.h.json",
    "Chipmunk.Arbiters",
    "chipmunk-arbiters",
)
