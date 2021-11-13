package com.sulake.habbo.groups
{
    import com.sulake.habbo.communication.messages.incoming.users.IGuildData;

    public class GuildSettingsData 
    {

        private var _guildType:int = 0;
        private var _rightsLevel:int = 0;
        private var _isModified:Boolean = false;

        public function GuildSettingsData(_arg_1:IGuildData=null)
        {
            if (_arg_1 == null)
            {
                return;
            };
            _guildType = _arg_1.guildType;
            _rightsLevel = _arg_1.guildRightsLevel;
        }

        public function get guildType():int
        {
            return (_guildType);
        }

        public function set guildType(_arg_1:int):void
        {
            if (_arg_1 != _guildType)
            {
                _isModified = true;
            };
            _guildType = _arg_1;
        }

        public function get rightsLevel():int
        {
            return (_rightsLevel);
        }

        public function set rightsLevel(_arg_1:int):void
        {
            if (_arg_1 != _rightsLevel)
            {
                _isModified = true;
            };
            _rightsLevel = _arg_1;
        }

        public function get isModified():Boolean
        {
            return (_isModified);
        }

        public function resetModified():void
        {
            _isModified = false;
        }


    }
}