package com.sulake.habbo.catalog.navigation
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;

    public class CatalogNode implements ICatalogNode 
    {

        private static const ICON_PREFIX:String = "icon_";

        private var _depth:int = 0;
        private var _localization:String = "";
        private var _pageId:int = -1;
        private var _pageName:String = "";
        private var _SafeStr_1465:int = 0;
        private var _children:Vector.<ICatalogNode>;
        private var _offerIds:Vector.<int>;
        private var _navigator:ICatalogNavigator;
        private var _parent:ICatalogNode;

        public function CatalogNode(_arg_1:ICatalogNavigator, _arg_2:NodeData, _arg_3:int, _arg_4:ICatalogNode)
        {
            _depth = _arg_3;
            _parent = _arg_4;
            _navigator = _arg_1;
            _localization = _arg_2.localization;
            _pageId = _arg_2.pageId;
            _pageName = _arg_2.pageName;
            _SafeStr_1465 = _arg_2.icon;
            _children = new Vector.<ICatalogNode>(0);
            _offerIds = _arg_2.offerIds;
        }

        public function get isOpen():Boolean
        {
            return (false);
        }

        public function get depth():int
        {
            return (_depth);
        }

        public function get isBranch():Boolean
        {
            return (_children.length > 0);
        }

        public function get isLeaf():Boolean
        {
            return (_children.length == 0);
        }

        public function get visible():Boolean
        {
            return (false);
        }

        public function get localization():String
        {
            return (_localization);
        }

        public function get pageId():int
        {
            return (_pageId);
        }

        public function get pageName():String
        {
            return (_pageName);
        }

        public function get children():Vector.<ICatalogNode>
        {
            return (_children);
        }

        public function get offerIds():Vector.<int>
        {
            return (_offerIds);
        }

        public function get navigator():ICatalogNavigator
        {
            return (_navigator);
        }

        public function get parent():ICatalogNode
        {
            return (_parent);
        }

        public function set parent(_arg_1:ICatalogNode):void
        {
        }

        public function dispose():void
        {
            for each (var _local_1:ICatalogNode in _children)
            {
                _local_1.dispose();
            };
            _children = null;
            _offerIds = null;
            _navigator = null;
            _parent = null;
            _pageName = "";
            _localization = "";
        }

        public function addChild(_arg_1:ICatalogNode):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _children.push(_arg_1);
        }

        public function activate():void
        {
        }

        public function deactivate():void
        {
        }

        public function open():void
        {
        }

        public function close():void
        {
        }

        public function get iconName():String
        {
            if (_SafeStr_1465 < 1)
            {
                return ("");
            };
            return ("icon_" + _SafeStr_1465.toString());
        }

        public function get offsetV():int
        {
            return (0);
        }


    }
}

