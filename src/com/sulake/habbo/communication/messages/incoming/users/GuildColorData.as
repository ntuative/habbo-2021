package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuildColorData 
    {

        private var _id:int;
        private var _color:uint;

        public function GuildColorData(_arg_1:IMessageDataWrapper)
        {
            _id = _arg_1.readInteger();
            _color = parseInt(_arg_1.readString(), 16);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get color():uint
        {
            return (_color);
        }

        public function get red():int
        {
            return ((_color >> 16) & 0xFF);
        }

        public function get green():int
        {
            return ((_color >> 8) & 0xFF);
        }

        public function get blue():int
        {
            return ((_color >> 0) & 0xFF);
        }


    }
}