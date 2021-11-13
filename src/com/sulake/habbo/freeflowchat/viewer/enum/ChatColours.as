package com.sulake.habbo.freeflowchat.viewer.enum
{
    import com.sulake.habbo.freeflowchat.data.ChatItem;
    import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;

    public class ChatColours 
    {

        public static const COLOUR_ARRAY:Array = [["@red@", 9115929], ["@cyan@", 0x7F7F], ["@blue@", 19609], ["@green@", 0x8000], ["@purple@", 0x4C004C]];


        public static function applyColourToChat(_arg_1:ChatItem, _arg_2:ChatStyle):void
        {
            for each (var _local_3:Array in COLOUR_ARRAY)
            {
                if (_arg_1.text.indexOf(_local_3[0]) == 0)
                {
                    _arg_2.textFormat.color = _local_3[1];
                    _arg_1.text = _arg_1.text.substr(_local_3[0].length);
                };
            };
        }


    }
}