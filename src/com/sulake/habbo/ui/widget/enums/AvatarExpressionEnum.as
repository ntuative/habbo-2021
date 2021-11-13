package com.sulake.habbo.ui.widget.enums
{
    public class AvatarExpressionEnum 
    {

        public static const _SafeStr_617:AvatarExpressionEnum = new AvatarExpressionEnum(0);
        public static const WAVE:AvatarExpressionEnum = new AvatarExpressionEnum(1);
        public static const BLOW:AvatarExpressionEnum = new AvatarExpressionEnum(2);
        public static const LAUGH:AvatarExpressionEnum = new AvatarExpressionEnum(3);
        public static const CRY:AvatarExpressionEnum = new AvatarExpressionEnum(4);
        public static const _SafeStr_592:AvatarExpressionEnum = new AvatarExpressionEnum(5);
        public static const JUMP:AvatarExpressionEnum = new AvatarExpressionEnum(6);
        public static const RESPECT:AvatarExpressionEnum = new AvatarExpressionEnum(7);

        private var _ordinal:int = 0;

        public function AvatarExpressionEnum(_arg_1:int):void
        {
            _ordinal = _arg_1;
        }

        public function get ordinal():int
        {
            return (_ordinal);
        }

        public function equals(_arg_1:AvatarExpressionEnum):Boolean
        {
            return ((_arg_1) && (_arg_1._ordinal == _ordinal));
        }


    }
}

