package com.sulake.habbo.communication.messages.incoming.callforhelp
{
    import com.sulake.habbo.communication.messages.incoming.moderation.INamed;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CfhSanctionTypeData implements INamed 
    {

        private var _name:String;
        private var _sanctionLengthInHours:int;
        private var _SafeStr_1708:int;
        private var _avatarOnly:Boolean;
        private var _tradeLockInfo:String = "";
        private var _machineBanInfo:String = "";

        public function CfhSanctionTypeData(_arg_1:IMessageDataWrapper)
        {
            _name = _arg_1.readString();
            _sanctionLengthInHours = _arg_1.readInteger();
            _SafeStr_1708 = _arg_1.readInteger();
            _avatarOnly = _arg_1.readBoolean();
            if (_arg_1.bytesAvailable)
            {
                _tradeLockInfo = _arg_1.readString();
            };
            if (_arg_1.bytesAvailable)
            {
                _machineBanInfo = _arg_1.readString();
            };
        }

        public function get name():String
        {
            return (_name);
        }

        public function get sanctionLengthInHours():int
        {
            return (_sanctionLengthInHours);
        }

        public function get avatarOnly():Boolean
        {
            return (_avatarOnly);
        }

        public function get tradeLockInfo():String
        {
            return (_tradeLockInfo);
        }

        public function get machineBanInfo():String
        {
            return (_machineBanInfo);
        }


    }
}

