package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildBadgeSettings 
    {

        private var _partId:int;
        private var _colorId:int;
        private var _position:int;

        public function GuildBadgeSettings(_arg_1:IMessageDataWrapper)
        {
            _partId = _arg_1.readInteger();
            _colorId = _arg_1.readInteger();
            _position = _arg_1.readInteger();
        }

        public function get partId():int
        {
            return (_partId);
        }

        public function get colorId():int
        {
            return (_colorId);
        }

        public function get position():int
        {
            return (_position);
        }


    }
}