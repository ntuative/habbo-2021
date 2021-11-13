package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class UserObjectMessageParser implements IMessageParser 
    {

        private var _SafeStr_698:int;
        private var _name:String;
        private var _SafeStr_1382:String;
        private var _SafeStr_2022:String;
        private var _SafeStr_2023:String;
        private var _realName:String;
        private var _SafeStr_2024:Boolean;
        private var _SafeStr_2025:int;
        private var _SafeStr_2026:int;
        private var _SafeStr_2027:int;
        private var _SafeStr_2028:Boolean;
        private var _SafeStr_2029:String;
        private var _SafeStr_2030:Boolean;
        private var _accountSafetyLocked:Boolean = false;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._SafeStr_698 = _arg_1.readInteger();
            this._name = _arg_1.readString();
            this._SafeStr_1382 = _arg_1.readString();
            this._SafeStr_2022 = _arg_1.readString();
            this._SafeStr_2023 = _arg_1.readString();
            this._realName = _arg_1.readString();
            this._SafeStr_2024 = _arg_1.readBoolean();
            this._SafeStr_2025 = _arg_1.readInteger();
            this._SafeStr_2026 = _arg_1.readInteger();
            this._SafeStr_2027 = _arg_1.readInteger();
            this._SafeStr_2028 = _arg_1.readBoolean();
            this._SafeStr_2029 = _arg_1.readString();
            this._SafeStr_2030 = _arg_1.readBoolean();
            this._accountSafetyLocked = _arg_1.readBoolean();
            return (true);
        }

        public function get id():int
        {
            return (this._SafeStr_698);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get figure():String
        {
            return (this._SafeStr_1382);
        }

        public function get sex():String
        {
            return (this._SafeStr_2022);
        }

        public function get customData():String
        {
            return (this._SafeStr_2023);
        }

        public function get realName():String
        {
            return (this._realName);
        }

        public function get directMail():Boolean
        {
            return (this._SafeStr_2024);
        }

        public function get respectTotal():int
        {
            return (this._SafeStr_2025);
        }

        public function get respectLeft():int
        {
            return (this._SafeStr_2026);
        }

        public function get petRespectLeft():int
        {
            return (this._SafeStr_2027);
        }

        public function get streamPublishingAllowed():Boolean
        {
            return (this._SafeStr_2028);
        }

        public function get lastAccessDate():String
        {
            return (this._SafeStr_2029);
        }

        public function get nameChangeAllowed():Boolean
        {
            return (this._SafeStr_2030);
        }

        public function get accountSafetyLocked():Boolean
        {
            return (_accountSafetyLocked);
        }


    }
}

