package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameStatusData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2GameStatusMessageParser implements IMessageParser 
    {

        private var _status:GameStatusData;


        public function get status():GameStatusData
        {
            return (_status);
        }

        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _status = new GameStatusData(_arg_1);
            return (true);
        }


    }
}