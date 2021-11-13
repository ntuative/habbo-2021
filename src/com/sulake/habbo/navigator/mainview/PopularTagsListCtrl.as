package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularTagData;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class PopularTagsListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _SafeStr_853:IItemListWindow;
        private var _SafeStr_2933:int;
        private var _SafeStr_2910:TagRenderer;

        public function PopularTagsListCtrl(_arg_1:HabboNavigator):void
        {
            _navigator = _arg_1;
            _SafeStr_2910 = new TagRenderer(_navigator);
        }

        public function dispose():void
        {
            if (_SafeStr_2910)
            {
                _SafeStr_2910.dispose();
                _SafeStr_2910 = null;
            };
        }

        public function set content(_arg_1:IWindowContainer):void
        {
            _content = _arg_1;
            _SafeStr_853 = ((_content) ? IItemListWindow(_content.findChildByName("item_list")) : null);
        }

        public function get content():IWindowContainer
        {
            return (_content);
        }

        public function refresh():void
        {
            var _local_3:int;
            var _local_1:PopularTagData;
            _SafeStr_2910.useHashTags = true;
            var _local_4:Array = _navigator.data.popularTags.tags;
            var _local_2:IWindowContainer = IWindowContainer(_SafeStr_853.getListItemAt(0));
            if (_local_2 == null)
            {
                _local_2 = IWindowContainer(_navigator.getXmlWindow("grs_popular_tag_row"));
                _SafeStr_853.addListItem(_local_2);
            };
            Util.hideChildren(_local_2);
            _local_3 = 0;
            while (_local_3 < _navigator.data.popularTags.tags.length)
            {
                _local_1 = _navigator.data.popularTags.tags[_local_3];
                _SafeStr_2910.refreshTag(_local_2, _local_3, _local_1.tagName);
                _local_3++;
            };
            Util.layoutChildrenInArea(_local_2, _local_2.width, 18, 3);
            _local_2.height = Util.getLowestPoint(_local_2);
            _content.findChildByName("no_tags_found").visible = (_local_4.length < 1);
        }

        private function refreshTagName(_arg_1:IWindowContainer, _arg_2:PopularTagData):void
        {
            var _local_3:String = "txt";
            var _local_4:ITextWindow = ITextWindow(_arg_1.findChildByName(_local_3));
            if (_arg_2 == null)
            {
                return;
            };
            _local_4.visible = true;
            _local_4.text = _arg_2.tagName;
        }


    }
}

