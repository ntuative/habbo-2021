package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BadgeAndPointLimit 
    {

        private var _badgeId:String;
        private var _limit:int;

        public function BadgeAndPointLimit(_arg_1:String, _arg_2:IMessageDataWrapper)
        {
            _badgeId = (("ACH_" + _arg_1) + _arg_2.readInteger());
            _limit = _arg_2.readInteger();
        }

        public function get badgeId():String
        {
            return (_badgeId);
        }

        public function get limit():int
        {
            return (_limit);
        }


    }
}