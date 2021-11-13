package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotForceOpenContextMenuParser implements IMessageParser 
    {

        private var _botId:int;


        public function flush():Boolean
        {
            _botId = -1;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _botId = _arg_1.readInteger();
            return (true);
        }

        public function get botId():int
        {
            return (_botId);
        }


    }
}