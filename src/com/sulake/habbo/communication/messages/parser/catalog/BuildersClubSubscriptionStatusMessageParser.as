package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BuildersClubSubscriptionStatusMessageParser implements IMessageParser 
    {

        private var _secondsLeft:int;
        private var _furniLimit:int;
        private var _maxFurniLimit:int;
        private var _secondsLeftWithGrace:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _secondsLeft = _arg_1.readInteger();
            _furniLimit = _arg_1.readInteger();
            _maxFurniLimit = _arg_1.readInteger();
            if (_arg_1.bytesAvailable)
            {
                _secondsLeftWithGrace = _arg_1.readInteger();
            }
            else
            {
                _secondsLeftWithGrace = _secondsLeft;
            };
            return (true);
        }

        public function get secondsLeft():int
        {
            return (_secondsLeft);
        }

        public function get furniLimit():int
        {
            return (_furniLimit);
        }

        public function get maxFurniLimit():int
        {
            return (_maxFurniLimit);
        }

        public function get secondsLeftWithGrace():int
        {
            return (_secondsLeftWithGrace);
        }


    }
}