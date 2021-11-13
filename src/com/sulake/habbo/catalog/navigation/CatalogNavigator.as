package com.sulake.habbo.catalog.navigation
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.TopViewSelector;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
    import com.sulake.habbo.catalog.event.CatalogEvent;
    import com.sulake.core.runtime.Component;

    public class CatalogNavigator implements ICatalogNavigator 
    {

        public static const DUMMY_PAGE_ID_FOR_OFFER_SEARCH:int = -12345678;

        private var _catalog:HabboCatalog;
        private var _container:IWindowContainer;
        private var _SafeStr_1460:String;
        private var _SafeStr_1459:ITabContextWindow;
        private var _SafeStr_853:IItemListWindow;
        private var _index:ICatalogNode;
        private var _SafeStr_1461:Vector.<ICatalogNode>;
        private var _offersToNodes:Dictionary;
        private var _SafeStr_1462:IWindow;
        private var _SafeStr_1463:IWindow;
        private var _listTemplate:IWindow;
        private var _SafeStr_1464:TopViewSelector;

        public function CatalogNavigator(_arg_1:HabboCatalog, _arg_2:IWindowContainer, _arg_3:String)
        {
            _catalog = _arg_1;
            _container = _arg_2;
            _SafeStr_1460 = _arg_3;
            _SafeStr_1461 = new Vector.<ICatalogNode>(0);
            _SafeStr_853 = (_container.findChildByName("navigationList") as IItemListWindow);
            _SafeStr_1462 = _SafeStr_853.removeListItem(_SafeStr_853.getListItemByName((_arg_3.toLowerCase() + "_topitem_template")));
            _SafeStr_1463 = _SafeStr_853.removeListItem(_SafeStr_853.getListItemByName((_arg_3.toLowerCase() + "_subitem_template")));
            _listTemplate = _SafeStr_853.removeListItem(_SafeStr_853.getListItemByName((_arg_3.toLowerCase() + "_list_template")));
            _SafeStr_1459 = ITabContextWindow(_container.findChildByName("tab_context"));
            if (_SafeStr_1459 != null)
            {
                if (_catalog.useNonTabbedCatalog())
                {
                    _SafeStr_1459.visible = false;
                }
                else
                {
                    _SafeStr_1464 = new TopViewSelector(this, _SafeStr_1459);
                };
            };
        }

        private static function searchNodesWith(_arg_1:String, _arg_2:Array, _arg_3:ICatalogNode, _arg_4:Vector.<ICatalogNode>):void
        {
            var _local_6:Boolean;
            var _local_5:String;
            try
            {
                if (((_arg_3.visible) && (_arg_3.pageId > 0)))
                {
                    _local_6 = false;
                    _local_5 = [_arg_3.pageName, _arg_3.localization].join(" ").toLowerCase();
                    _local_5 = _local_5.replace(/ /gi, "");
                    if (_local_5.indexOf(_arg_1) > -1)
                    {
                        _arg_4.push(_arg_3);
                        _local_6 = true;
                    };
                    if (!_local_6)
                    {
                        for each (var _local_7:String in _arg_2)
                        {
                            if (_local_5.indexOf(_local_7) >= 0)
                            {
                                _arg_4.push(_arg_3);
                                break;
                            };
                        };
                    };
                };
                for each (var _local_8:ICatalogNode in _arg_3.children)
                {
                    searchNodesWith(_arg_1, _arg_2, _local_8, _arg_4);
                };
            }
            catch(e:Error)
            {
                Logger.log((("Error when loading nodes by name " + _arg_1) + ":"), e);
            };
        }


        public function get initialized():Boolean
        {
            return (!(_index == null));
        }

        public function dispose():void
        {
            if (_index != null)
            {
                _index.dispose();
            };
            _index = null;
            _offersToNodes = null;
            _SafeStr_1461 = null;
            _catalog = null;
            _container = null;
            _SafeStr_853 = null;
        }

        public function buildCatalogIndex(_arg_1:NodeData):void
        {
            _index = null;
            _offersToNodes = new Dictionary();
            _index = buildIndexNode(_arg_1, 0, null);
        }

        public function showIndex():void
        {
            if (_index == null)
            {
                return;
            };
            _SafeStr_853.removeListItems();
            if (_SafeStr_1464 != null)
            {
                _SafeStr_1464.clearTabs();
            };
            for each (var _local_1:ICatalogNode in _index.children)
            {
                if (_local_1.visible)
                {
                    if (_catalog.useNonTabbedCatalog())
                    {
                        (_local_1 as CatalogNodeRenderable).addToList(_SafeStr_853);
                    }
                    else
                    {
                        _SafeStr_1464.addTabItem(_local_1);
                    };
                };
            };
            if (_SafeStr_1464 != null)
            {
                _SafeStr_1464.selectTabByIndex(0);
            };
        }

        public function showNodeContent(_arg_1:ICatalogNode):void
        {
            if (_index == null)
            {
                return;
            };
            _SafeStr_853.removeListItems();
            if (((_arg_1 == null) || (!(_arg_1.visible))))
            {
                return;
            };
            if (_arg_1.children.length)
            {
                for each (var _local_2:ICatalogNode in _arg_1.children)
                {
                    if (_local_2.visible)
                    {
                        (_local_2 as CatalogNodeRenderable).addToList(_SafeStr_853);
                    };
                };
                activateNode(_arg_1.children[0]);
            }
            else
            {
                openCatalogPage(_arg_1);
            };
        }

        private function openCategoryForNode(_arg_1:ICatalogNode):ICatalogNode
        {
            var _local_3:int;
            var _local_2:ICatalogNode = _arg_1.parent;
            while ((((!(_local_2 == null)) && (!(_local_2.parent == null))) && (!(_local_2.parent.pageName == "root"))))
            {
                _local_2 = _local_2.parent;
            };
            if (((_SafeStr_1464) && (_local_2.parent)))
            {
                _local_3 = _local_2.parent.children.indexOf(_local_2);
                _SafeStr_1464.selectTabByIndex(_local_3);
            };
            showNodeContent(_local_2);
            return (_local_2);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function activateNode(_arg_1:ICatalogNode):void
        {
            var _local_3:Number;
            var _local_5:Number;
            var _local_7:int;
            var _local_8:Boolean = (_SafeStr_1461.indexOf(_arg_1) >= 0);
            var _local_2:Boolean = _arg_1.isOpen;
            var _local_6:Vector.<ICatalogNode> = new Vector.<ICatalogNode>(0);
            for each (var _local_4:ICatalogNode in _SafeStr_1461)
            {
                _local_4.deactivate();
                if (_local_4.depth < _arg_1.depth)
                {
                    _local_6.push(_local_4);
                }
                else
                {
                    _local_4.close();
                };
            };
            _SafeStr_1461 = _local_6;
            _arg_1.activate();
            if (((_local_8) && (_local_2)))
            {
                _arg_1.close();
            }
            else
            {
                _arg_1.open();
            };
            if (_SafeStr_1461.indexOf(_arg_1) < 0)
            {
                _SafeStr_1461.push(_arg_1);
            };
            if (_arg_1.isBranch)
            {
                if (((_arg_1.parent) && (_arg_1.parent is CatalogNodeRenderable)))
                {
                    (_arg_1.parent as CatalogNodeRenderable).updateChildListHeight();
                };
                _local_3 = 0;
                _local_5 = 0;
                _local_7 = 0;
                while (_local_7 < _SafeStr_853.numListItems)
                {
                    if (_SafeStr_853.getListItemAt(_local_7).visible)
                    {
                        _local_5 = (_local_5 + _SafeStr_853.getListItemAt(_local_7).height);
                    };
                    _local_7++;
                };
                for each (_arg_1 in _SafeStr_1461)
                {
                    _local_3 = (_local_3 + _arg_1.offsetV);
                };
                if ((_local_3 - _SafeStr_853.height) > 0)
                {
                    _SafeStr_853.scrollV = (_local_3 / _local_5);
                };
            };
            if (_arg_1.pageId > -1)
            {
                openCatalogPage(_arg_1);
            };
        }

        private function openCatalogPage(_arg_1:ICatalogNode):void
        {
            _catalog.loadCatalogPage(_arg_1.pageId, -1, _SafeStr_1460);
            _catalog.events.dispatchEvent(new CatalogPageOpenedEvent(_arg_1.pageId, _arg_1.localization));
        }

        public function openPage(_arg_1:String):void
        {
            var _local_2:ICatalogNode = getNodeByName(_arg_1);
            if (((!(_local_2 == null)) && (_local_2.visible)))
            {
                _catalog.loadCatalogPage(_local_2.pageId, -1, _SafeStr_1460);
                openNavigatorAtNode(_local_2);
            }
            else
            {
                if (((!(_local_2 == null)) && (!(_local_2.visible))))
                {
                    _catalog.events.dispatchEvent(new CatalogEvent("CATALOG_INVISIBLE_PAGE_VISITED"));
                };
                loadFrontPage();
            };
        }

        public function openPageById(_arg_1:int, _arg_2:int):void
        {
            var _local_3:ICatalogNode;
            var _local_4:Vector.<ICatalogNode> = undefined;
            if (!initialized)
            {
                _catalog.openCatalogPageById(_arg_1, _arg_2, _SafeStr_1460);
            }
            else
            {
                if (_arg_1 == -12345678)
                {
                    _local_4 = getNodesByOfferId(_arg_2, true);
                    if (_local_4 != null)
                    {
                        _local_3 = _local_4[0];
                    };
                }
                else
                {
                    _local_3 = getNodeById(_arg_1);
                };
                if (_local_3 != null)
                {
                    _catalog.loadCatalogPage(_local_3.pageId, _arg_2, _SafeStr_1460);
                    openNavigatorAtNode(_local_3);
                };
            };
        }

        public function openPageByOfferId(_arg_1:int):void
        {
            var _local_3:Vector.<ICatalogNode> = undefined;
            var _local_2:ICatalogNode;
            if (!initialized)
            {
                _catalog.openCatalogPageById(-12345678, _arg_1, _SafeStr_1460);
            }
            else
            {
                _local_3 = getNodesByOfferId(_arg_1);
                if (_local_3 != null)
                {
                    _local_2 = _local_3[0];
                    _catalog.loadCatalogPage(_local_2.pageId, _arg_1, _SafeStr_1460);
                    openNavigatorAtNode(_local_2);
                };
            };
        }

        public function deactivateCurrentNode():void
        {
            for each (var _local_1:ICatalogNode in _SafeStr_1461)
            {
                _local_1.deactivate();
                _local_1.close();
            };
            _SafeStr_1461 = new Vector.<ICatalogNode>(0);
        }

        public function filter(_arg_1:String, _arg_2:Array):void
        {
            var _local_4:Vector.<ICatalogNode> = new Vector.<ICatalogNode>(0);
            searchNodesWith(_arg_1, _arg_2, _index, _local_4);
            _SafeStr_853.removeListItems();
            for each (var _local_3:ICatalogNode in _local_4)
            {
                Logger.log(("Found node: " + [_local_3.pageId, _local_3.pageName, _local_3.localization]));
                if (_local_3.visible)
                {
                    (_local_3 as CatalogNodeRenderable).addToList(_SafeStr_853);
                };
            };
        }

        private function openNavigatorAtNode(_arg_1:ICatalogNode):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            deactivateCurrentNode();
            var _local_2:ICatalogNode = _arg_1.parent;
            while (((!(_local_2 == null)) && (!(_local_2.parent == null))))
            {
                _local_2.open();
                if (_catalog.useNonTabbedCatalog())
                {
                    _SafeStr_1461.push(_local_2);
                };
                _local_2 = _local_2.parent;
            };
            if (!_catalog.useNonTabbedCatalog())
            {
                openCategoryForNode(_arg_1);
            };
            activateNode(_arg_1);
        }

        public function loadFrontPage():void
        {
            if (_index == null)
            {
                return;
            };
            var _local_1:ICatalogNode = getFirstNavigable(_index);
            if (_local_1 == null)
            {
                return;
            };
            Logger.log((((("Load front page: " + _local_1.localization) + "(") + _local_1.pageId) + ")"));
            _catalog.loadCatalogPage(_local_1.pageId, -1, _SafeStr_1460);
        }

        private function getFirstNavigable(_arg_1:ICatalogNode):ICatalogNode
        {
            var _local_2:ICatalogNode;
            if (((_arg_1.visible) && (!(_arg_1 == _index))))
            {
                return (_arg_1);
            };
            for each (var _local_3:ICatalogNode in _arg_1.children)
            {
                _local_2 = getFirstNavigable(_local_3);
                if (_local_2 != null)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        private function buildIndexNode(_arg_1:NodeData, _arg_2:int, _arg_3:ICatalogNode):ICatalogNode
        {
            var _local_4:ICatalogNode;
            var _local_5:Boolean = _arg_1.visible;
            if (!_local_5)
            {
                _local_4 = new CatalogNode(this, _arg_1, _arg_2, _arg_3);
            }
            else
            {
                _local_4 = new CatalogNodeRenderable(this, _arg_1, _arg_2, _arg_3);
            };
            for each (var _local_6:int in _local_4.offerIds)
            {
                if ((_local_6 in _offersToNodes))
                {
                    _offersToNodes[_local_6].push(_local_4);
                }
                else
                {
                    _offersToNodes[_local_6] = new <ICatalogNode>[_local_4];
                };
            };
            _arg_2++;
            for each (var _local_7:NodeData in _arg_1.children)
            {
                _local_4.addChild(buildIndexNode(_local_7, _arg_2, _local_4));
            };
            return (_local_4);
        }

        public function getNodesByOfferId(_arg_1:int, _arg_2:Boolean=false):Vector.<ICatalogNode>
        {
            var _local_4:Vector.<ICatalogNode> = undefined;
            if (_offersToNodes != null)
            {
                if (_arg_2)
                {
                    _local_4 = new Vector.<ICatalogNode>(0);
                    for each (var _local_3:ICatalogNode in _offersToNodes[_arg_1])
                    {
                        if (_local_3.visible)
                        {
                            _local_4.push(_local_3);
                        };
                    };
                    if (_local_4.length > 0)
                    {
                        return (_local_4);
                    };
                    return (null);
                };
                return (_offersToNodes[_arg_1]);
            };
            return (null);
        }

        public function getNodeByName(_arg_1:String):ICatalogNode
        {
            return ((_index != null) ? getFirstNodeByName(_arg_1, _index) : null);
        }

        public function getOptionalNodeByName(_arg_1:String):ICatalogNode
        {
            return ((_index) ? getFirstNodeByName(_arg_1, _index) : null);
        }

        public function getNodeById(_arg_1:int, _arg_2:ICatalogNode=null):ICatalogNode
        {
            if (_arg_2 == null)
            {
                _arg_2 = _index;
            };
            if (!(!(_arg_2 == null)))
            {
                return (null);
            };
            var _local_3:ICatalogNode;
            if (((_arg_2.pageId == _arg_1) && (!(_arg_2 == _index))))
            {
                _local_3 = _arg_2;
            }
            else
            {
                for each (var _local_4:ICatalogNode in _arg_2.children)
                {
                    _local_3 = getNodeById(_arg_1, _local_4);
                    if (_local_3 != null) break;
                };
            };
            return (_local_3);
        }

        private function getFirstNodeByName(_arg_1:String, _arg_2:ICatalogNode):ICatalogNode
        {
            var _local_3:ICatalogNode;
            try
            {
                if (((_arg_2.pageName == _arg_1) && (!(_arg_2 == _index))))
                {
                    _local_3 = _arg_2;
                }
                else
                {
                    for each (var _local_4:ICatalogNode in _arg_2.children)
                    {
                        _local_3 = getFirstNodeByName(_arg_1, _local_4);
                        if (_local_3 != null) break;
                    };
                };
            }
            catch(e:Error)
            {
                Logger.log((("Error when loading node by name " + _arg_1) + ":"), e);
            };
            return (_local_3);
        }

        public function get listTemplate():IWindow
        {
            return (_listTemplate);
        }

        public function get isDeepHierarchy():Boolean
        {
            return ((_catalog as Component).getBoolean("catalog.deep.hierarchy"));
        }

        public function getItemTemplate(_arg_1:int):IWindow
        {
            if (isDeepHierarchy)
            {
                return ((_arg_1 > 2) ? _SafeStr_1463 : _SafeStr_1462);
            };
            return ((_arg_1 == 1) ? _SafeStr_1462 : _SafeStr_1463);
        }


    }
}

