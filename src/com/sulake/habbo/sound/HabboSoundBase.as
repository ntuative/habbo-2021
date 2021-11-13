package com.sulake.habbo.sound
{
    import flash.media.SoundChannel;
    import flash.media.Sound;
    import flash.media.SoundTransform;
    import flash.events.Event;

    public class HabboSoundBase implements IHabboSound 
    {

        private var _SafeStr_3745:SoundChannel = null;
        private var _SafeStr_1139:Boolean;
        private var _volume:Number;
        private var _SafeStr_3280:int;
        protected var _soundObject:Sound = null;

        public function HabboSoundBase(_arg_1:Sound, _arg_2:int=0)
        {
            _soundObject = _arg_1;
            _soundObject.addEventListener("complete", onComplete);
            _volume = 1;
            _SafeStr_1139 = false;
            _SafeStr_3280 = _arg_2;
        }

        protected function getSoundObject():Sound
        {
            return (_soundObject);
        }

        protected function getSoundChannel():SoundChannel
        {
            return (_SafeStr_3745);
        }

        protected function setSoundChannel(_arg_1:SoundChannel):void
        {
            _SafeStr_3745 = _arg_1;
        }

        protected function setComplete(_arg_1:Boolean):void
        {
            _SafeStr_1139 = _arg_1;
        }

        public function dispose():void
        {
            stop();
            _SafeStr_3745 = null;
            _soundObject = null;
        }

        public function play(_arg_1:Number=0):Boolean
        {
            _SafeStr_1139 = false;
            _SafeStr_3745 = _soundObject.play(0, _SafeStr_3280);
            this.volume = _volume;
            return (true);
        }

        public function stop():Boolean
        {
            if (_SafeStr_3745)
            {
                _SafeStr_3745.stop();
            };
            return (true);
        }

        public function get volume():Number
        {
            return (_volume);
        }

        public function set volume(_arg_1:Number):void
        {
            _volume = _arg_1;
            setChannelVolume(_arg_1);
        }

        protected function setChannelVolume(_arg_1:Number):void
        {
            if (_SafeStr_3745 != null)
            {
                _SafeStr_3745.soundTransform = new SoundTransform(_arg_1);
            };
        }

        public function get position():Number
        {
            return (_SafeStr_3745.position);
        }

        public function set position(_arg_1:Number):void
        {
        }

        public function get length():Number
        {
            return (_soundObject.length);
        }

        public function get ready():Boolean
        {
            return (!(_soundObject.isBuffering));
        }

        public function get finished():Boolean
        {
            return (!(_SafeStr_1139));
        }

        public function get fadeOutSeconds():Number
        {
            return (0);
        }

        public function set fadeOutSeconds(_arg_1:Number):void
        {
        }

        public function get fadeInSeconds():Number
        {
            return (0);
        }

        public function set fadeInSeconds(_arg_1:Number):void
        {
        }

        private function onComplete(_arg_1:Event):void
        {
            _SafeStr_1139 = true;
        }


    }
}

