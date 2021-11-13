package com.sulake.habbo.utils.animation
{
    import flash.display.DisplayObject;

    public class TweenUtils 
    {

        public static const FAST_ALPHA_TWEEN_TIME:Number = 0.2;
        public static const STANDARD_ALPHA_TWEEN_TIME:Number = 0.4;
        public static const SLOW_ALPHA_TWEEN_TIME_DOUBLE:Number = 0.8;
        public static const REALLY_SLOW_ALPHA_TWEEN_TIME:Number = 1.2;
        public static const STANDARD_ANCHOR_TWEEN_TIME:Number = 0.4;

        public static var _SafeStr_265:Juggler = new Juggler();


        public static function alphaTweenVisible(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:String="linear"):Tween
        {
            _arg_1.alpha = 0;
            var _local_5:Tween = new Tween(_arg_1, _arg_3, _arg_4);
            _local_5.animate("alpha", 1);
            _local_5.delay = _arg_2;
            TweenUtils._SafeStr_265.add(_local_5);
            return (_local_5);
        }

        public static function alphaTweenInvisible(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number, _arg_4:String="linear"):Tween
        {
            _arg_1.alpha = 1;
            var _local_5:Tween = new Tween(_arg_1, _arg_3, _arg_4);
            _local_5.animate("alpha", 0);
            _local_5.delay = _arg_2;
            TweenUtils._SafeStr_265.add(_local_5);
            return (_local_5);
        }

        public static function alphaTweenBlink(_arg_1:DisplayObject, _arg_2:Number, _arg_3:Number):Tween
        {
            _arg_1.alpha = 0;
            var _local_4:Tween = new Tween(_arg_1, _arg_3, "easeOutBack");
            _local_4.animate("alpha", 0.4);
            _local_4.delay = _arg_2;
            TweenUtils._SafeStr_265.add(_local_4);
            return (_local_4);
        }


    }
}

