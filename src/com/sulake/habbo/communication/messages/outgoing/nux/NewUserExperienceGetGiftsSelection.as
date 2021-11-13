package com.sulake.habbo.communication.messages.outgoing.nux
{
        public class NewUserExperienceGetGiftsSelection 
    {

        private var _dayIndex:int;
        private var _stepIndex:int;
        private var _giftIndex:int;

        public function NewUserExperienceGetGiftsSelection(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            _dayIndex = _arg_1;
            _stepIndex = _arg_2;
            _giftIndex = _arg_3;
        }

        public function get dayIndex():int
        {
            return (_dayIndex);
        }

        public function get stepIndex():int
        {
            return (_stepIndex);
        }

        public function get giftIndex():int
        {
            return (_giftIndex);
        }


    }
}