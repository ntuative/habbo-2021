package com.sulake.habbo.freeflowchat.viewer.enum
{
    public class ChatBubbleWidth 
    {

        public static const NORMAL:int = 350;
        public static const THIN:int = 240;
        public static const WIDE:int = 2000;


        public static function accordingToRoomChatSetting(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 1:
                    return (350);
                case 2:
                    return (240);
                case 0:
                    return (2000);
                default:
                    return (350);
            };
        }


    }
}