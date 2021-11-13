package com.sulake.habbo.ui.widget.messages
{
    import com.sulake.core.window.IWindowContainer;

    public class RoomWidgetAvatarEditorMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_4181:String = "RWCM_OPEN_AVATAR_EDITOR";
        public static const WIDGET_MESSAGE_GET_WARDROBE:String = "RWCM_GET_WARDROBE";
        public static const _SafeStr_4182:String = "RWAEM_AVATAR_EDITOR_VIEW_DISPOSED";

        private var _context:IWindowContainer;

        public function RoomWidgetAvatarEditorMessage(_arg_1:String, _arg_2:IWindowContainer=null)
        {
            super(_arg_1);
            _context = _arg_2;
        }

        public function get context():IWindowContainer
        {
            return (_context);
        }


    }
}

