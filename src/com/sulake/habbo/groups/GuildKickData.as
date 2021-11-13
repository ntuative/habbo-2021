package com.sulake.habbo.groups
{
    public class GuildKickData 
    {

        private var _kickTargetId:int;
        private var _kickGuildId:int;
        private var _targetBlocked:Boolean;

        public function GuildKickData(_arg_1:int, _arg_2:int, _arg_3:Boolean=false)
        {
            _kickTargetId = _arg_1;
            _kickGuildId = _arg_2;
            _targetBlocked = _arg_3;
        }

        public function get kickTargetId():int
        {
            return (_kickTargetId);
        }

        public function get kickGuildId():int
        {
            return (_kickGuildId);
        }

        public function get targetBlocked():Boolean
        {
            return (_targetBlocked);
        }


    }
}