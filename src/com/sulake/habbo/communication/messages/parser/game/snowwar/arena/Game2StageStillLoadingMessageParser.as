package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class Game2StageStillLoadingMessageParser implements IMessageParser 
    {

        private var _percentage:int;
        private var _finishedPlayers:Array;


        public function get percentage():int
        {
            return (_percentage);
        }

        public function get finishedPlayers():Array
        {
            return (_finishedPlayers);
        }

        public function flush():Boolean
        {
            return (false);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _percentage = _arg_1.readInteger();
            _finishedPlayers = [];
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _finishedPlayers.push(_arg_1.readInteger());
                _local_3++;
            };
            return (true);
        }


    }
}