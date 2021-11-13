package com.sulake.habbo.communication.messages.parser.room.bots
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BotCommandConfigurationParser implements IMessageParser 
    {

        private var _botId:int;
        private var _commandId:int;
        private var _data:String;


        public function get botId():int
        {
            return (_botId);
        }

        public function get commandId():int
        {
            return (_commandId);
        }

        public function get data():String
        {
            return (_data);
        }

        public function flush():Boolean
        {
            _botId = -1;
            _commandId = -1;
            _data = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _botId = _arg_1.readInteger();
            _commandId = _arg_1.readInteger();
            _data = _arg_1.readString();
            return (true);
        }


    }
}