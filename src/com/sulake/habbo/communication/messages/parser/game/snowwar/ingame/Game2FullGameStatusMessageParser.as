package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FullGameStatusData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2FullGameStatusMessageParser implements IMessageParser 
    {

        private var _fullStatus:FullGameStatusData;


        public function get fullStatus():FullGameStatusData
        {
            return (_fullStatus);
        }

        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _fullStatus = new FullGameStatusData(_arg_1);
            return (true);
        }


    }
}