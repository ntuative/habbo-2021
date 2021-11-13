package com.sulake.core.window
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.ActivatorController;
    import com.sulake.core.window.components.BackgroundController;
    import com.sulake.core.window.components.BorderController;
    import com.sulake.core.window.components.BoxSizerController;
    import com.sulake.core.window.components.BubbleController;
    import com.sulake.core.window.components.ButtonController;
    import com.sulake.core.window.components.SelectableButtonController;
    import com.sulake.core.window.components.BitmapWrapperController;
    import com.sulake.core.window.components.CheckBoxController;
    import com.sulake.core.window.components.ContainerController;
    import com.sulake.core.window.components.ContainerButtonController;
    import com.sulake.core.window.components.CloseButtonController;
    import com.sulake.core.window.components.DisplayObjectWrapperController;
    import com.sulake.core.window.components.ScrollBarLiftController;
    import com.sulake.core.window.components.DropMenuController;
    import com.sulake.core.window.components.DropMenuItemController;
    import com.sulake.core.window.components.DropListController;
    import com.sulake.core.window.components.DropListItemController;
    import com.sulake.core.window.components.FormattedTextController;
    import com.sulake.core.window.components.FrameController;
    import com.sulake.core.window.components.HeaderController;
    import com.sulake.core.window.components.HTMLTextController;
    import com.sulake.core.window.components.IconController;
    import com.sulake.core.window.components.ItemListController;
    import com.sulake.core.window.components.ItemGridController;
    import com.sulake.core.window.components.TextLabelController;
    import com.sulake.core.window.components.TextLinkController;
    import com.sulake.core.window.components.PasswordFieldController;
    import com.sulake.core.window.components.RadioButtonController;
    import com.sulake.core.window.components.RegionController;
    import com.sulake.core.window.components.ScalerController;
    import com.sulake.core.window.components.ScrollBarController;
    import com.sulake.core.window.components.ScrollableItemListWindow;
    import com.sulake.core.window.components.ScrollableItemGridWindow;
    import com.sulake.core.window.components.SelectorController;
    import com.sulake.core.window.components.SelectorListController;
    import com.sulake.core.window.components.StaticBitmapWrapperController;
    import com.sulake.core.window.components.TabButtonController;
    import com.sulake.core.window.components.TabContainerButtonController;
    import com.sulake.core.window.components.TabContextController;
    import com.sulake.core.window.components.TextController;
    import com.sulake.core.window.components.TextFieldController;
    import com.sulake.core.window.components.ToolTipController;
    import com.sulake.core.window.components.WidgetWindowController;
    import com.sulake.core.window.components.*;

    public class Classes 
    {

        protected static var _SafeStr_1216:Dictionary;


        public static function init():void
        {
            if (!_SafeStr_1216)
            {
                _SafeStr_1216 = new Dictionary();
                _SafeStr_1216[0] = WindowController;
                _SafeStr_1216[40] = ActivatorController;
                _SafeStr_1216[2] = BackgroundController;
                _SafeStr_1216[30] = BorderController;
                _SafeStr_1216[17] = BoxSizerController;
                _SafeStr_1216[45] = BubbleController;
                _SafeStr_1216[46] = WindowController;
                _SafeStr_1216[47] = WindowController;
                _SafeStr_1216[48] = WindowController;
                _SafeStr_1216[49] = WindowController;
                _SafeStr_1216[60] = ButtonController;
                _SafeStr_1216[61] = ButtonController;
                _SafeStr_1216[67] = SelectableButtonController;
                _SafeStr_1216[68] = SelectableButtonController;
                _SafeStr_1216[69] = SelectableButtonController;
                _SafeStr_1216[21] = BitmapWrapperController;
                _SafeStr_1216[70] = CheckBoxController;
                _SafeStr_1216[4] = ContainerController;
                _SafeStr_1216[41] = ContainerButtonController;
                _SafeStr_1216[72] = CloseButtonController;
                _SafeStr_1216[20] = DisplayObjectWrapperController;
                _SafeStr_1216[76] = ScrollBarLiftController;
                _SafeStr_1216[102] = DropMenuController;
                _SafeStr_1216[103] = DropMenuItemController;
                _SafeStr_1216[105] = DropListController;
                _SafeStr_1216[106] = DropListItemController;
                _SafeStr_1216[15] = FormattedTextController;
                _SafeStr_1216[35] = FrameController;
                _SafeStr_1216[6] = HeaderController;
                _SafeStr_1216[11] = HTMLTextController;
                _SafeStr_1216[1] = IconController;
                _SafeStr_1216[50] = ItemListController;
                _SafeStr_1216[51] = ItemListController;
                _SafeStr_1216[50] = ItemListController;
                _SafeStr_1216[52] = ItemGridController;
                _SafeStr_1216[54] = ItemGridController;
                _SafeStr_1216[53] = ItemGridController;
                _SafeStr_1216[12] = TextLabelController;
                _SafeStr_1216[14] = TextLinkController;
                _SafeStr_1216[78] = PasswordFieldController;
                _SafeStr_1216[71] = RadioButtonController;
                _SafeStr_1216[5] = RegionController;
                _SafeStr_1216[120] = ScalerController;
                _SafeStr_1216[130] = ScrollBarController;
                _SafeStr_1216[131] = ScrollBarController;
                _SafeStr_1216[139] = ButtonController;
                _SafeStr_1216[137] = ButtonController;
                _SafeStr_1216[138] = ButtonController;
                _SafeStr_1216[136] = ButtonController;
                _SafeStr_1216[132] = ScrollBarLiftController;
                _SafeStr_1216[133] = ScrollBarLiftController;
                _SafeStr_1216[134] = WindowController;
                _SafeStr_1216[135] = WindowController;
                _SafeStr_1216[56] = ScrollableItemListWindow;
                _SafeStr_1216[140] = ScrollableItemGridWindow;
                _SafeStr_1216[42] = SelectorController;
                _SafeStr_1216[43] = SelectorListController;
                _SafeStr_1216[23] = StaticBitmapWrapperController;
                _SafeStr_1216[93] = TabButtonController;
                _SafeStr_1216[94] = TabContainerButtonController;
                _SafeStr_1216[90] = ContainerController;
                _SafeStr_1216[91] = TabContextController;
                _SafeStr_1216[92] = SelectorListController;
                _SafeStr_1216[10] = TextController;
                _SafeStr_1216[77] = TextFieldController;
                _SafeStr_1216[8] = ToolTipController;
                _SafeStr_1216[16] = WidgetWindowController;
            };
        }

        public static function getWindowClassByType(_arg_1:uint):Class
        {
            return (_SafeStr_1216[_arg_1]);
        }


    }
}

