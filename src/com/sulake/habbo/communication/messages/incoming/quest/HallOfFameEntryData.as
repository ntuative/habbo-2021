package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class HallOfFameEntryData implements ILandingPageUserEntry 
    {

        private var _userId:int;
        private var _userName:String;
        private var _figure:String;
        private var _rank:int;
        private var _currentScore:int;

        public function HallOfFameEntryData(_arg_1:IMessageDataWrapper)
        {
            _userId = _arg_1.readInteger();
            _userName = _arg_1.readString();
            _figure = _arg_1.readString();
            _rank = _arg_1.readInteger();
            _currentScore = _arg_1.readInteger();
        }

        public function get userId():int
        {
            return (_userId);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get rank():int
        {
            return (_rank);
        }

        public function get currentScore():int
        {
            return (_currentScore);
        }


    }
}