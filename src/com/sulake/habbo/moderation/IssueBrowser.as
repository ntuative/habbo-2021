package com.sulake.habbo.moderation
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class IssueBrowser 
    {

        private const MY_ISSUES:String = "my_issues";
        private const OPEN_ISSUES:String = "open_issues";
        private const PICKED_ISSUES:String = "picked_issues";
        private const CLOSED_ISSUES:String = "closed_issues";

        private var _issueManager:IssueManager;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _window:IFrameWindow;
        private var _tabContext:ITabContextWindow;
        private var _SafeStr_2827:IIssueBrowserView;
        private var _SafeStr_2828:IIssueBrowserView;
        private var _SafeStr_2829:IIssueBrowserView;
        private var _SafeStr_2830:PickedIssuesView;

        public function IssueBrowser(_arg_1:IssueManager, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            _issueManager = _arg_1;
            _windowManager = _arg_2;
            _assets = _arg_3;
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get assets():IAssetLibrary
        {
            return (_assets);
        }

        public function get issueManager():IssueManager
        {
            return (_issueManager);
        }

        public function show():void
        {
            if (_window == null)
            {
                createMainFrame();
            };
            _window.visible = true;
            _window.activate();
            update();
        }

        public function isOpen():Boolean
        {
            return ((!(_window == null)) && (_window.visible));
        }

        private function createMainFrame():void
        {
            var _local_1:IWindow;
            var _local_5:IWindow;
            var _local_6:IWindow;
            var _local_2:ITabButtonWindow;
            var _local_4:int;
            if (_window == null)
            {
                _window = (createWindow("issue_browser_xml") as IFrameWindow);
                if (_window == null)
                {
                    return;
                };
                _local_1 = _window.desktop;
                _window.x = ((_local_1.width / 2) - (_window.width / 2));
                _window.y = ((_local_1.height / 2) - (_window.height / 2));
                _local_5 = _window.findChildByTag("close");
                if (_local_5 != null)
                {
                    _local_5.addEventListener("WME_CLICK", onClose);
                };
                _local_6 = _window.findChildByName("auto_pick");
                if (_local_6 != null)
                {
                    _local_6.addEventListener("WME_CLICK", onAutoPick);
                };
                _tabContext = (_window.findChildByName("tab_context") as ITabContextWindow);
                _local_4 = 0;
                while (_local_4 < _tabContext.numTabItems)
                {
                    _local_2 = _tabContext.getTabItemAt(_local_4);
                    _local_2.addEventListener("WE_SELECTED", onTabSelected);
                    _local_4++;
                };
                _SafeStr_2828 = new MyIssuesView(issueManager, this, (_window.findChildByName("my_issues_prototype") as IWindowContainer));
                _SafeStr_2829 = new OpenIssuesView(issueManager, this, (_window.findChildByName("open_issues_prototype") as IWindowContainer));
                _SafeStr_2830 = new PickedIssuesView(issueManager, this, (_window.findChildByName("picked_issues_prototype") as IWindowContainer));
            };
            _tabContext = (_window.findChildByName("tab_context") as ITabContextWindow);
            if (((_tabContext == null) || (_tabContext.container == null)))
            {
                return;
            };
            var _local_3:ISelectableWindow = _tabContext.selector.getSelectableByName("open_issues");
            _tabContext.selector.setSelected(_local_3);
        }

        private function selectView(_arg_1:String):void
        {
            var _local_2:IIssueBrowserView = getView(_arg_1);
            if (_SafeStr_2827 == _local_2)
            {
                return;
            };
            if (_SafeStr_2827 != null)
            {
                _SafeStr_2827.visible = false;
            };
            _SafeStr_2827 = _local_2;
            if (_SafeStr_2827 == null)
            {
                return;
            };
            _SafeStr_2827.view.width = _tabContext.container.width;
            _SafeStr_2827.view.height = _tabContext.container.height;
            _SafeStr_2827.visible = true;
            _SafeStr_2827.update();
        }

        private function getView(_arg_1:String):IIssueBrowserView
        {
            switch (_arg_1)
            {
                case "my_issues":
                    return (_SafeStr_2828);
                case "open_issues":
                    return (_SafeStr_2829);
                case "picked_issues":
                    return (_SafeStr_2830);
                default:
                    return (null);
            };
        }

        private function onTabSelected(_arg_1:WindowEvent):void
        {
            if (((_arg_1 == null) || (_arg_1.window == null)))
            {
                return;
            };
            selectView(_arg_1.window.name);
        }

        public function update():void
        {
            if (((_window == null) || (!(_window.visible))))
            {
                return;
            };
            if (_SafeStr_2827 == null)
            {
                return;
            };
            _SafeStr_2827.update();
        }

        public function createWindow(_arg_1:String):IWindow
        {
            if (((_windowManager == null) || (_assets == null)))
            {
                return (null);
            };
            var _local_2:XmlAsset = (_assets.getAssetByName(_arg_1) as XmlAsset);
            if (((_local_2 == null) || (_local_2.content == null)))
            {
                return (null);
            };
            return (_windowManager.buildFromXML((_local_2.content as XML)));
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            _window.visible = false;
        }

        private function onAutoPick(_arg_1:WindowMouseEvent):void
        {
            if (_issueManager != null)
            {
                _issueManager.autoPick("issue browser pick next");
            };
        }


    }
}

