package com.sulake.habbo.sound.music
{
    import flash.utils.getTimer;

    public class SongStartRequestData 
    {

        private var _songId:int;
        private var _SafeStr_3736:Number;
        private var _playLength:Number;
        private var _playRequestTime:int;
        private var _fadeInSeconds:Number;
        private var _fadeOutSeconds:Number;

        public function SongStartRequestData(_arg_1:int, _arg_2:Number, _arg_3:Number, _arg_4:Number=2, _arg_5:Number=1)
        {
            _songId = _arg_1;
            _SafeStr_3736 = _arg_2;
            _playLength = _arg_3;
            _fadeInSeconds = _arg_4;
            _fadeOutSeconds = _arg_5;
            _playRequestTime = getTimer();
        }

        public function get songId():int
        {
            return (_songId);
        }

        public function get startPos():Number
        {
            if (_SafeStr_3736 < 0)
            {
                return (0);
            };
            return (_SafeStr_3736 + ((getTimer() - _playRequestTime) / 1000));
        }

        public function get playLength():Number
        {
            return (_playLength);
        }

        public function get fadeInSeconds():Number
        {
            return (_fadeInSeconds);
        }

        public function get fadeOutSeconds():Number
        {
            return (_fadeOutSeconds);
        }


    }
}

