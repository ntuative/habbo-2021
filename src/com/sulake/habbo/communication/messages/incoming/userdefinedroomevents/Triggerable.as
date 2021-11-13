package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Triggerable 
    {

        private var _stuffTypeSelectionEnabled:Boolean;
        private var _furniLimit:int;
        private var _stuffIds:Array = [];
        private var _id:int;
        private var _stringParam:String;
        private var _intParams:Array = [];
        private var _stuffTypeId:int;
        private var _stuffTypeSelectionCode:int;

        public function Triggerable(_arg_1:IMessageDataWrapper)
        {
            var _local_4:int;
            var _local_2:int;
            super();
            _stuffTypeSelectionEnabled = _arg_1.readBoolean();
            _furniLimit = _arg_1.readInteger();
            var _local_5:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_5)
            {
                _local_2 = _arg_1.readInteger();
                _stuffIds.push(_local_2);
                _local_4++;
            };
            _stuffTypeId = _arg_1.readInteger();
            _id = _arg_1.readInteger();
            _stringParam = _arg_1.readString();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _intParams.push(_arg_1.readInteger());
                _local_4++;
            };
            _stuffTypeSelectionCode = _arg_1.readInteger();
        }

        public function get stuffTypeSelectionEnabled():Boolean
        {
            return (_stuffTypeSelectionEnabled);
        }

        public function get stuffTypeSelectionCode():int
        {
            return (_stuffTypeSelectionCode);
        }

        public function set stuffTypeSelectionCode(_arg_1:int):void
        {
            _stuffTypeSelectionCode = _arg_1;
        }

        public function get furniLimit():int
        {
            return (_furniLimit);
        }

        public function get stuffIds():Array
        {
            return (_stuffIds);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get stringParam():String
        {
            return (_stringParam);
        }

        public function get intParams():Array
        {
            return (_intParams);
        }

        public function get code():int
        {
            return (0);
        }

        public function get stuffTypeId():int
        {
            return (_stuffTypeId);
        }

        public function getBoolean(_arg_1:int):Boolean
        {
            return (_intParams[_arg_1] == 1);
        }


    }
}