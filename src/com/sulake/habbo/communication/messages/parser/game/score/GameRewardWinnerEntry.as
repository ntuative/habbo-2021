package com.sulake.habbo.communication.messages.parser.game.score
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GameRewardWinnerEntry 
    {

        private var _name:String;
        private var _figure:String;
        private var _gender:String;
        private var _rank:int;
        private var _score:int;

        public function GameRewardWinnerEntry(_arg_1:IMessageDataWrapper)
        {
            _name = _arg_1.readString();
            _figure = _arg_1.readString();
            _gender = _arg_1.readString();
            _rank = _arg_1.readInteger();
            _score = _arg_1.readInteger();
        }

        public function get name():String
        {
            return (_name);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get gender():String
        {
            return (_gender);
        }

        public function get rank():int
        {
            return (_rank);
        }

        public function get score():int
        {
            return (_score);
        }


    }
}