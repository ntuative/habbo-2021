package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
        public class AvatarEffect 
    {

        private var _type:int;
        private var _subType:int;
        private var _duration:int;
        private var _inactiveEffectsInInventory:int;
        private var _secondsLeftIfActive:int;
        private var _isPermanent:Boolean;


        public function get type():int
        {
            return (_type);
        }

        public function set type(_arg_1:int):void
        {
            _type = _arg_1;
        }

        public function get subType():int
        {
            return (_subType);
        }

        public function set subType(_arg_1:int):void
        {
            _subType = _arg_1;
        }

        public function get duration():int
        {
            return (_duration);
        }

        public function set duration(_arg_1:int):void
        {
            _duration = _arg_1;
        }

        public function get inactiveEffectsInInventory():int
        {
            return (_inactiveEffectsInInventory);
        }

        public function set inactiveEffectsInInventory(_arg_1:int):void
        {
            _inactiveEffectsInInventory = _arg_1;
        }

        public function get secondsLeftIfActive():int
        {
            return (_secondsLeftIfActive);
        }

        public function set secondsLeftIfActive(_arg_1:int):void
        {
            _secondsLeftIfActive = _arg_1;
        }

        public function get isPermanent():Boolean
        {
            return (_isPermanent);
        }

        public function set isPermanent(_arg_1:Boolean):void
        {
            _isPermanent = _arg_1;
        }


    }
}