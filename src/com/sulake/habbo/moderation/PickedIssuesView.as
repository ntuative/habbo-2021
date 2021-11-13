package com.sulake.habbo.moderation
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;

    public class PickedIssuesView implements IIssueBrowserView 
    {

        private var _SafeStr_2848:IssueManager;
        private var _SafeStr_2849:IssueBrowser;
        private var _view:IWindowContainer;
        private var _SafeStr_2871:IssueListView;

        public function PickedIssuesView(_arg_1:IssueManager, _arg_2:IssueBrowser, _arg_3:IWindowContainer)
        {
            _SafeStr_2848 = _arg_1;
            _SafeStr_2849 = _arg_2;
            _view = _arg_3;
            _view.visible = false;
            var _local_4:IItemListWindow = (_view.findChildByName("issue_list") as IItemListWindow);
            _SafeStr_2871 = new IssueListView(_arg_1, _arg_2, _local_4);
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function set visible(_arg_1:Boolean):void
        {
            _view.visible = _arg_1;
        }

        public function update():void
        {
            var _local_1:Array = _SafeStr_2848.getBundles("issue_bundle_picked");
            _SafeStr_2871.update(_local_1);
        }


    }
}

