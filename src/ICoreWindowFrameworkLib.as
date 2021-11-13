package 
{
    import com.sulake.iid.IIDCoreWindowManager;
    import com.sulake.core.window.ICoreWindowManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.components._SafeStr_134;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components._SafeStr_144;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.components._SafeStr_143;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.window.components.IDragBarWindow;
    import com.sulake.core.window.components.IDropListItemWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IHeaderWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.INotifyWindow;
    import com.sulake.core.window.components._SafeStr_116;
    import com.sulake.core.window.components.IRadioButtonSelectionWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IScalerWindow;
    import com.sulake.core.window.components.IScrollableWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.components.ITabContentWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.ISelectorListWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IToolBarWindow;
    import com.sulake.core.window.enum._SafeStr_154;
    import com.sulake.core.window.enum._SafeStr_132;
    import com.sulake.core.window.enum._SafeStr_137;
    import com.sulake.core.window.enum._SafeStr_142;
    import com.sulake.core.window.enum._SafeStr_112;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowMessage;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.utils.IMargins;

        public class ICoreWindowFrameworkLib 
    {

        public static var IIDCoreWindowManager:Class = com.sulake.iid.IIDCoreWindowManager;
        public static var ICoreWindowManager:Class = com.sulake.core.window.ICoreWindowManager;
        public static var IWindow:Class = com.sulake.core.window.IWindow;
        public static var IWindowContainer:Class = com.sulake.core.window.IWindowContainer;
        public static var IWindowContext:Class = com.sulake.core.window.IWindowContext;
        public static var _SafeStr_134:Class = com.sulake.core.window.components._SafeStr_134;
        public static var IBitmapWrapperWindow:Class = com.sulake.core.window.components.IBitmapWrapperWindow;
        public static var _SafeStr_124:Class = com.sulake.core.window.components._SafeStr_124;
        public static var _SafeStr_101:Class = com.sulake.core.window.components._SafeStr_101;
        public static var _SafeStr_144:Class = com.sulake.core.window.components._SafeStr_144;
        public static var _SafeStr_108:Class = com.sulake.core.window.components._SafeStr_108;
        public static var _SafeStr_143:Class = com.sulake.core.window.components._SafeStr_143;
        public static var IDesktopWindow:Class = com.sulake.core.window.components.IDesktopWindow;
        public static var IDisplayObjectWrapper:Class = com.sulake.core.window.components.IDisplayObjectWrapper;
        public static var IDragBarWindow:Class = com.sulake.core.window.components.IDragBarWindow;
        public static var _SafeStr_594:Class = IDropListItemWindow;
        public static var IDropMenuWindow:Class = com.sulake.core.window.components.IDropMenuWindow;
        public static var IFrameWindow:Class = com.sulake.core.window.components.IFrameWindow;
        public static var IHeaderWindow:Class = com.sulake.core.window.components.IHeaderWindow;
        public static var IIconWindow:Class = com.sulake.core.window.components.IIconWindow;
        public static var IInteractiveWindow:Class = com.sulake.core.window.components.IInteractiveWindow;
        public static var IItemGridWindow:Class = com.sulake.core.window.components.IItemGridWindow;
        public static var IItemListWindow:Class = com.sulake.core.window.components.IItemListWindow;
        public static var INotifyWindow:Class = com.sulake.core.window.components.INotifyWindow;
        public static var _SafeStr_116:Class = com.sulake.core.window.components._SafeStr_116;
        public static var IRadioButtonSelectionWindow:Class = com.sulake.core.window.components.IRadioButtonSelectionWindow;
        public static var IRadioButtonWindow:Class = com.sulake.core.window.components.IRadioButtonWindow;
        public static var IRegionWindow:Class = com.sulake.core.window.components.IRegionWindow;
        public static var IScalerWindow:Class = com.sulake.core.window.components.IScalerWindow;
        public static var IScrollableWindow:Class = com.sulake.core.window.components.IScrollableWindow;
        public static var IScrollbarWindow:Class = com.sulake.core.window.components.IScrollbarWindow;
        public static var ISelectableWindow:Class = com.sulake.core.window.components.ISelectableWindow;
        public static var ISelectorWindow:Class = com.sulake.core.window.components.ISelectorWindow;
        public static var ITabButtonWindow:Class = com.sulake.core.window.components.ITabButtonWindow;
        public static var ITabContentWindow:Class = com.sulake.core.window.components.ITabContentWindow;
        public static var ITabContextWindow:Class = com.sulake.core.window.components.ITabContextWindow;
        public static var ISelectorListWindow:Class = com.sulake.core.window.components.ISelectorListWindow;
        public static var ITextFieldWindow:Class = com.sulake.core.window.components.ITextFieldWindow;
        public static var ITextWindow:Class = com.sulake.core.window.components.ITextWindow;
        public static var IToolBarWindow:Class = com.sulake.core.window.components.IToolBarWindow;
        public static var _SafeStr_154:Class = com.sulake.core.window.enum._SafeStr_154;
        public static var _SafeStr_132:Class = com.sulake.core.window.enum._SafeStr_132;
        public static var _SafeStr_137:Class = com.sulake.core.window.enum._SafeStr_137;
        public static var _SafeStr_142:Class = com.sulake.core.window.enum._SafeStr_142;
        public static var _SafeStr_112:Class = com.sulake.core.window.enum._SafeStr_112;
        public static var WindowEvent:Class = com.sulake.core.window.events.WindowEvent;
        public static var WindowKeyboardEvent:Class = com.sulake.core.window.events.WindowKeyboardEvent;
        public static var WindowMessage:Class = com.sulake.core.window.events.WindowMessage;
        public static var WindowMouseEvent:Class = com.sulake.core.window.events.WindowMouseEvent;
        public static var IMargins:Class = com.sulake.core.window.utils.IMargins;


    }
}

