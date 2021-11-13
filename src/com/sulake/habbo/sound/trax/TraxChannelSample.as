package com.sulake.habbo.sound.trax
{
    import __AS3__.vec.Vector;

    public class TraxChannelSample 
    {

        private var _SafeStr_3740:TraxSample = null;
        private var _offset:int = 0;

        public function TraxChannelSample(_arg_1:TraxSample, _arg_2:int)
        {
            _SafeStr_3740 = _arg_1;
            _offset = _arg_2;
        }

        public function setSample(_arg_1:Vector.<int>, _arg_2:int, _arg_3:int):void
        {
            _offset = _SafeStr_3740.setSample(_arg_1, _arg_2, _arg_3, _offset);
        }

        public function addSample(_arg_1:Vector.<int>, _arg_2:int, _arg_3:int):void
        {
            _offset = _SafeStr_3740.addSample(_arg_1, _arg_2, _arg_3, _offset);
        }


    }
}

