package com.sulake.habbo.communication.messages.incoming.nux
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NewUserExperienceGiftOptions 
    {

        private var _dayIndex:int;
        private var _stepIndex:int;
        private var _options:Vector.<NewUserExperienceGift>;

        public function NewUserExperienceGiftOptions(_arg_1:IMessageDataWrapper)
        {
            var _local_2:int;
            super();
            _dayIndex = _arg_1.readInteger();
            _stepIndex = _arg_1.readInteger();
            _options = new Vector.<NewUserExperienceGift>(0);
            var _local_3:int = _arg_1.readInteger();
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                _options.push(new NewUserExperienceGift(_arg_1));
                _local_2++;
            };
        }

        public function get dayIndex():int
        {
            return (_dayIndex);
        }

        public function get stepIndex():int
        {
            return (_stepIndex);
        }

        public function get options():Vector.<NewUserExperienceGift>
        {
            return (_options);
        }


    }
}