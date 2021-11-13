package com.sulake.habbo.ui.widget.messages
{
    import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;

    public class RoomWidgetAvatarExpressionMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4183:String = "RWCM_MESSAGE_AVATAR_EXPRESSION";

        private var _animation:AvatarExpressionEnum;

        public function RoomWidgetAvatarExpressionMessage(_arg_1:AvatarExpressionEnum)
        {
            super("RWCM_MESSAGE_AVATAR_EXPRESSION");
            _animation = _arg_1;
        }

        public function get animation():AvatarExpressionEnum
        {
            return (_animation);
        }


    }
}

