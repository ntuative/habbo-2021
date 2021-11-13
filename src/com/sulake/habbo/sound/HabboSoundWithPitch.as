package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.media.SoundTransform;

    public class HabboSoundWithPitch extends HabboSoundBase implements IUpdateReceiver 
    {

        private const SILENCE_MS:uint = 50;
        private const FADEIN_MS:uint = 175;

        private var _SafeStr_3762:Number;
        private var _SafeStr_3763:Sound;
        private var _SafeStr_3720:ByteArray;
        private var _SafeStr_3764:int;
        private var _SafeStr_3765:uint = 0;
        private var _SafeStr_3766:uint = 0;
        private var _SafeStr_3767:Boolean = false;

        public function HabboSoundWithPitch(_arg_1:Sound, _arg_2:Number=1)
        {
            super(_arg_1);
            _SafeStr_3762 = _arg_2;
            _SafeStr_3763 = new Sound();
            extractMonoSamples();
            setPitch(_SafeStr_3762);
        }

        override public function dispose():void
        {
            super.dispose();
            _SafeStr_3763 = null;
            _SafeStr_3720.clear();
            _SafeStr_3720 = null;
        }

        override public function play(_arg_1:Number=0):Boolean
        {
            stop();
            _SafeStr_3766 = _SafeStr_3765;
            _SafeStr_3767 = false;
            setComplete(false);
            setSoundChannel(_SafeStr_3763.play(0, 0, new SoundTransform(0)));
            return (true);
        }

        override public function stop():Boolean
        {
            if (getSoundChannel() != null)
            {
                getSoundChannel().stop();
            };
            return (true);
        }

        public function update(_arg_1:uint):void
        {
            _SafeStr_3765 = (_SafeStr_3765 + _arg_1);
            var _local_2:uint = (_SafeStr_3765 - _SafeStr_3766);
            if (((_SafeStr_3766 > 0) && (_local_2 < 50)))
            {
                setChannelVolume(0);
            }
            else
            {
                if ((((_SafeStr_3766 > 0) && (_local_2 >= 50)) && (_local_2 < 175)))
                {
                    setChannelVolume((volume * (_local_2 / 175)));
                }
                else
                {
                    if (!_SafeStr_3767)
                    {
                        setChannelVolume(volume);
                        _SafeStr_3767 = true;
                    };
                };
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_3720 == null);
        }

        public function setPitch(_arg_1:Number):void
        {
            var _local_5:Number;
            var _local_4:int;
            _SafeStr_3762 = _arg_1;
            var _local_6:ByteArray = new ByteArray();
            var _local_3:uint = uint(((_SafeStr_3720.length / 4) * _SafeStr_3762));
            var _local_2:Number = 0;
            _local_4 = 0;
            while (((_local_4 < _local_3) && ((_local_2 * 4) < _SafeStr_3720.length)))
            {
                _SafeStr_3720.position = (_local_2 * 4);
                _local_5 = _SafeStr_3720.readFloat();
                _local_6.writeFloat(_local_5);
                _local_6.writeFloat(_local_5);
                _local_2 = (_local_2 + _SafeStr_3762);
                _local_4++;
            };
            _local_6.position = 0;
            _SafeStr_3763.loadPCMFromByteArray(_local_6, (_local_6.length / 8), "float");
        }

        private function extractMonoSamples():void
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_1:ByteArray = new ByteArray();
            _soundObject.extract(_local_1, (_soundObject.length * 44.1), 0);
            _SafeStr_3720 = new ByteArray();
            _SafeStr_3764 = (_local_1.length / 8);
            _local_1.position = 0;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3764)
            {
                _local_3 = _local_1.readFloat();
                _local_1.readFloat();
                _SafeStr_3720.writeFloat(_local_3);
                _local_2++;
            };
        }


    }
}

