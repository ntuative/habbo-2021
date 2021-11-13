package com.codeazur.as3swf.data
{
    import com.codeazur.as3swf.SWFData;
    import com.codeazur.utils.StringUtils;

    public class SWFActionValue 
    {

        public var type:uint;
        public var string:String;
        public var number:Number;
        public var register:uint;
        public var boolean:Boolean;
        public var integer:uint;
        public var constant:uint;

        public function SWFActionValue(_arg_1:SWFData=null)
        {
            if (_arg_1 != null)
            {
                parse(_arg_1);
            };
        }

        public function parse(_arg_1:SWFData):void
        {
            type = _arg_1.readUI8();
            switch (type)
            {
                case 0:
                    string = _arg_1.readString();
                    return;
                case 1:
                    number = _arg_1.readFLOAT();
                    return;
                case 2:
                    return;
                case 3:
                    return;
                case 4:
                    register = _arg_1.readUI8();
                    return;
                case 5:
                    boolean = (!(_arg_1.readUI8() == 0));
                    return;
                case 6:
                    number = _arg_1.readDOUBLE();
                    return;
                case 7:
                    integer = _arg_1.readUI32();
                    return;
                case 8:
                    constant = _arg_1.readUI8();
                    return;
                case 9:
                    constant = _arg_1.readUI16();
                    return;
                default:
                    throw (new Error(("Unknown ActionValueType: " + type)));
            };
        }

        public function publish(_arg_1:SWFData):void
        {
            _arg_1.writeUI8(type);
            switch (type)
            {
                case 0:
                    _arg_1.writeString(string);
                    return;
                case 1:
                    _arg_1.writeFLOAT(number);
                    return;
                case 2:
                    return;
                case 3:
                    return;
                case 4:
                    _arg_1.writeUI8(register);
                    return;
                case 5:
                    _arg_1.writeUI8(((boolean) ? 1 : 0));
                    return;
                case 6:
                    _arg_1.writeDOUBLE(number);
                    return;
                case 7:
                    _arg_1.writeUI32(integer);
                    return;
                case 8:
                    _arg_1.writeUI8(constant);
                    return;
                case 9:
                    _arg_1.writeUI16(constant);
                    return;
                default:
                    throw (new Error(("Unknown ActionValueType: " + type)));
            };
        }

        public function clone():SWFActionValue
        {
            var _local_1:SWFActionValue = new SWFActionValue();
            switch (type)
            {
                case 1:
                case 6:
                    _local_1.number = number;
                    break;
                case 8:
                case 9:
                    _local_1.constant = constant;
                    break;
                case 2:
                    break;
                case 3:
                    break;
                case 0:
                    _local_1.string = string;
                    break;
                case 4:
                    _local_1.register = register;
                    break;
                case 5:
                    _local_1.boolean = boolean;
                    break;
                case 7:
                    _local_1.integer = integer;
                    break;
                default:
                    throw (new Error(("Unknown ActionValueType: " + type)));
            };
            return (_local_1);
        }

        public function toString():String
        {
            var _local_1:String = "";
            switch (type)
            {
                case 0:
                    _local_1 = (StringUtils.simpleEscape(string) + " (string)");
                    break;
                case 1:
                    _local_1 = (number + " (number)");
                    break;
                case 2:
                    _local_1 = "null";
                    break;
                case 3:
                    _local_1 = "undefined";
                    break;
                case 4:
                    _local_1 = (register + " (register)");
                    break;
                case 5:
                    _local_1 = (boolean + " (boolean)");
                    break;
                case 6:
                    _local_1 = (number + " (double)");
                    break;
                case 7:
                    _local_1 = (integer + " (integer)");
                    break;
                case 8:
                case 9:
                    _local_1 = (constant + " (constant)");
                    break;
                default:
                    _local_1 = "unknown";
            };
            return (_local_1);
        }


    }
}