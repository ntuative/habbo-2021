package com.sulake.habbo.ui.widget.furniture.contextmenu
{
    import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.contextmenu.IContextMenuParentWidget;

    public class FurnitureContextInfoView extends ButtonMenuView 
    {

        protected var _SafeStr_4065:IRoomObject;
        protected var _SafeStr_906:String;

        public function FurnitureContextInfoView(_arg_1:IContextMenuParentWidget)
        {
            super(_arg_1);
        }

        public static function setup(_arg_1:FurnitureContextInfoView, _arg_2:IRoomObject, _arg_3:String=""):void
        {
            _arg_1._SafeStr_4065 = _arg_2;
            _arg_1._SafeStr_906 = _arg_3;
            setupContext(_arg_1);
        }


        protected function get roomObject():IRoomObject
        {
            return (_SafeStr_4065);
        }

        override public function dispose():void
        {
            _SafeStr_4065 = null;
            super.dispose();
        }


    }
}

