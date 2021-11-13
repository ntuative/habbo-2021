package com.sulake.habbo.room.object.visualization.avatar.additions
{
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;

    public class _SafeStr_183 
    {

        public static const WAVE:int = 1;
        public static const BLOW:int = 2;
        public static const LAUGH:int = 3;
        public static const CRY:int = 4;
        public static const _SafeStr_592:int = 5;


        public static function make(_arg_1:int, _arg_2:int, _arg_3:AvatarVisualization):IExpressionAddition
        {
            switch (_arg_2)
            {
                case 2:
                    return (new FloatingHeart(_arg_1, 2, _arg_3));
                default:
                    return (new ExpressionAddition(_arg_1, _arg_2, _arg_3));
            };
        }


    }
}

