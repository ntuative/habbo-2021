package com.sulake.habbo.ui.widget.avatarinfo
{
    public class UserNameView extends AvatarContextInfoView 
    {

        public static const DEFAULT_BG_COLOR:uint = 4288528218;
        public static const DEFAULT_FADE_DELAY_MS:int = 8000;

        private var _objectId:int;
        private var _isGameRoomMode:Boolean;

        public function UserNameView(_arg_1:AvatarInfoWidget, _arg_2:Boolean=false)
        {
            super(_arg_1);
            _isGameRoomMode = _arg_2;
        }

        public static function setup(_arg_1:UserNameView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:uint=4288528218, _arg_8:int=8000):void
        {
            _arg_1._objectId = _arg_6;
            _arg_1._SafeStr_3933 = _arg_8;
            AvatarContextInfoView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
            _arg_1._window.color = _arg_7;
        }


        public function get objectId():int
        {
            return (_objectId);
        }

        public function get isGameRoomMode():Boolean
        {
            return (_isGameRoomMode);
        }

        override public function get maximumBlend():Number
        {
            if (_isGameRoomMode)
            {
                return (0.75);
            };
            return (super.maximumBlend);
        }


    }
}

