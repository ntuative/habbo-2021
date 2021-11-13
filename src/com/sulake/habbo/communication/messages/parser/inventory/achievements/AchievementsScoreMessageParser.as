package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class AchievementsScoreMessageParser implements IMessageParser 
    {

        private var _score:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _score = _arg_1.readInteger();
            return (true);
        }

        public function get score():int
        {
            return (_score);
        }


    }
}