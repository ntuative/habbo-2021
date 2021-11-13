package com.sulake.core.communication.wireformat
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import flash.utils.ByteArray;
    import com.hurlant.util._SafeStr_15;

        internal final class EvaMessageDataWrapper implements IMessageDataWrapper 
    {

        private var _SafeStr_698:int;
        private var _SafeStr_690:ByteArray;

        public function EvaMessageDataWrapper(_arg_1:int, _arg_2:ByteArray)
        {
            _SafeStr_698 = _arg_1;
            _SafeStr_690 = _arg_2;
        }

        public function getID():int
        {
            return (_SafeStr_698);
        }

        public function readString():String
        {
            return (_SafeStr_690.readUTF());
        }

        public function readInteger():int
        {
            return (_SafeStr_690.readInt());
        }

        public function readBoolean():Boolean
        {
            return (_SafeStr_690.readBoolean());
        }

        public function readShort():int
        {
            return (_SafeStr_690.readShort());
        }

        public function readByte():int
        {
            return (_SafeStr_690.readByte());
        }

        public function readFloat():Number
        {
            return (_SafeStr_690.readFloat());
        }

        public function readDouble():Number
        {
            return (_SafeStr_690.readDouble());
        }

        public function get bytesAvailable():uint
        {
            return (_SafeStr_690.bytesAvailable);
        }

        public function toString():String
        {
            return ((((("id=" + _SafeStr_698) + ", pos=") + _SafeStr_690.position) + ", data=") + _SafeStr_15.fromArray(_SafeStr_690, true));
        }


    }
}

