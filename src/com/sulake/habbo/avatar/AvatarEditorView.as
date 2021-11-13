package com.sulake.habbo.avatar
{
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.common.IAvatarEditorGridView;
    import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.core.window.IWindow;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.avatar.common.AvatarEditorGridView;
    import com.sulake.habbo.avatar.effects.AvatarEditorGridViewEffects;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IWidgetWindow;

    public class AvatarEditorView 
    {

        private static const SAVE_TIMEOUT_MS:int = 1500;
        private static const DEFAULT_LOCATION:Point = new Point(100, 30);

        public static var THUMB_WINDOW:IWindowContainer;
        public static var COLOUR_WINDOW:IWindowContainer;
        public static var TAB_BACKGROUND_COLOUR:int = 0x666666;

        private var _editor:HabboAvatarEditor;
        private var _SafeStr_1376:IWindowContainer;
        private var _SafeStr_1377:String;
        private var _SafeStr_1378:ITabContextWindow;
        private var _SafeStr_1379:IFrameWindow;
        private var _SafeStr_442:IWindowContainer;
        private var _SafeStr_1373:Timer;
        private var _avatarDirection:int = 4;
        private var _SafeStr_1380:String;
        private var _showWardrobeOnUpdate:Boolean = true;
        private var _SafeStr_1375:Array = [];
        private var _SafeStr_1374:Array = ["generic", "head", "torso", "legs", "hotlooks", "wardrobe"];
        private var _categoryContainers:Dictionary;
        private var _gridView:IAvatarEditorGridView;
        private var _effectsGridView:IAvatarEditorGridView;
        private var _avatarEditorNameChangeView:AvatarEditorNameChangeView;

        public function AvatarEditorView(_arg_1:HabboAvatarEditor, _arg_2:Array)
        {
            _editor = _arg_1;
            _SafeStr_1373 = new Timer(1500, 1);
            _SafeStr_1373.addEventListener("timer", onUpdate);
            if (_arg_1.manager.getBoolean("effects.in.avatar.editor"))
            {
                _SafeStr_1374.push("effects");
            };
            if (_arg_2 == null)
            {
                _arg_2 = _SafeStr_1374;
            };
            for each (var _local_3:String in _arg_2)
            {
                _SafeStr_1375.push(_local_3);
            };
            createWindow();
        }

        public function dispose():void
        {
            var _local_3:IWindowContainer;
            var _local_2:IWindowContainer;
            var _local_1:IWindowContainer;
            if (_SafeStr_1373 != null)
            {
                _SafeStr_1373.stop();
                _SafeStr_1373.removeEventListener("timer", onUpdate);
                _SafeStr_1373 = null;
            };
            if (_SafeStr_1378)
            {
                _SafeStr_1378.dispose();
                _SafeStr_1378 = null;
            };
            if (_SafeStr_1376)
            {
                _SafeStr_1376.dispose();
                _SafeStr_1376 = null;
            };
            if (_SafeStr_442 != null)
            {
                _SafeStr_442.dispose();
                _SafeStr_442 = null;
            };
            if (_SafeStr_1379)
            {
                _SafeStr_1379.dispose();
                _SafeStr_1379 = null;
            };
            if (_SafeStr_1376 != null)
            {
                _local_3 = (_SafeStr_1376.findChildByName("figureContainer") as IWindowContainer);
                if (_local_3 != null)
                {
                    while (_local_3.numChildren > 0)
                    {
                        _local_3.removeChildAt(0);
                    };
                };
                _local_2 = (_SafeStr_1376.findChildByName("contentArea") as IWindowContainer);
                if (_local_2 != null)
                {
                    while (_local_2.numChildren > 0)
                    {
                        _local_2.removeChildAt(0);
                    };
                };
                _local_1 = (_SafeStr_1376.findChildByName("sideContainer") as IWindowContainer);
                if (_local_1 != null)
                {
                    while (_local_1.numChildren > 0)
                    {
                        _local_1.removeChildAt(0);
                    };
                };
                _editor = null;
            };
        }

        public function getFrame(_arg_1:Array, _arg_2:String=null):IFrameWindow
        {
            if (_SafeStr_1379)
            {
                _SafeStr_1379.visible = true;
                _SafeStr_1379.activate();
                return (_SafeStr_1379);
            };
            if (_SafeStr_1379)
            {
                _SafeStr_1379.dispose();
                _SafeStr_1379 = null;
            };
            var _local_3:XmlAsset = (_editor.manager.assets.getAssetByName("AvatarEditorFrame") as XmlAsset);
            if (_local_3)
            {
                _SafeStr_1379 = (_editor.manager.windowManager.buildFromXML((_local_3.content as XML)) as IFrameWindow);
            };
            if (_SafeStr_1379 == null)
            {
                return (null);
            };
            var _local_4:IWindowContainer = (_SafeStr_1379.findChildByName("maincontent") as IWindowContainer);
            if (!embedToContext(_local_4, _arg_1))
            {
                _SafeStr_1379.dispose();
                _SafeStr_1379 = null;
                return (null);
            };
            if (((_arg_2) && (!(_SafeStr_1379.header == null))))
            {
                _SafeStr_1379.header.title.text = _arg_2;
            };
            _SafeStr_1379.position = DEFAULT_LOCATION;
            _SafeStr_1379.findChildByName("header_button_close").procedure = windowEventProc;
            return (_SafeStr_1379);
        }

        public function embedToContext(_arg_1:IWindowContainer, _arg_2:Array):Boolean
        {
            var _local_3:int;
            if (!validateAvailableCategories(_arg_2))
            {
                return (false);
            };
            if (_arg_1)
            {
                _local_3 = _arg_1.getChildIndex(_SafeStr_1376);
                if (_local_3)
                {
                    _arg_1.removeChildAt(_local_3);
                };
                _arg_1.addChild(_SafeStr_1376);
            }
            else
            {
                if (_SafeStr_442 == null)
                {
                    _SafeStr_442 = (_editor.manager.windowManager.createWindow("avatarEditorContainer", "", 4, 3, (0x020000 | 0x01), new Rectangle(0, 0, 2, 2), null, 0) as IWindowContainer);
                    _SafeStr_442.addChild(_SafeStr_1376);
                };
                _local_3 = _SafeStr_442.getChildIndex(_SafeStr_1376);
                if (_local_3)
                {
                    _arg_1.removeChildAt(_local_3);
                };
                _SafeStr_442.visible = true;
            };
            return (true);
        }

        public function validateAvailableCategories(_arg_1:Array):Boolean
        {
            if (_arg_1 == null)
            {
                return (validateAvailableCategories(_SafeStr_1374));
            };
            if (_arg_1.length != _SafeStr_1375.length)
            {
                return (false);
            };
            for each (var _local_2:String in _arg_1)
            {
                if (_SafeStr_1375.indexOf(_local_2) < 0)
                {
                    return (false);
                };
            };
            return (true);
        }

        private function onUpdate(_arg_1:Event=null):void
        {
            _SafeStr_1373.stop();
            if (_SafeStr_1376)
            {
                _SafeStr_1376.findChildByName("save").enable();
            };
        }

        public function show():void
        {
            if (_SafeStr_1379)
            {
                _SafeStr_1379.visible = true;
            }
            else
            {
                if (_SafeStr_1376)
                {
                    _SafeStr_1376.visible = true;
                };
            };
        }

        public function hide():void
        {
            if (_SafeStr_1379)
            {
                _SafeStr_1379.visible = false;
            }
            else
            {
                if (_SafeStr_1376)
                {
                    _SafeStr_1376.visible = false;
                };
            };
        }

        private function createWindow():void
        {
            var _local_4:int;
            var _local_3:ITabButtonWindow;
            var _local_5:int;
            var _local_7:IWindow;
            if (_SafeStr_1376 == null)
            {
                _SafeStr_1376 = (_editor.manager.windowManager.buildFromXML(((_editor.manager.assets.getAssetByName("AvatarEditorContent") as XmlAsset).content as XML)) as IWindowContainer);
            };
            if (THUMB_WINDOW == null)
            {
                THUMB_WINDOW = (_SafeStr_1376.findChildByName("thumb_template") as IWindowContainer);
                if (THUMB_WINDOW)
                {
                    _SafeStr_1376.removeChild(THUMB_WINDOW);
                };
            };
            if (COLOUR_WINDOW == null)
            {
                COLOUR_WINDOW = (_SafeStr_1376.findChildByName("palette_template") as IWindowContainer);
                if (COLOUR_WINDOW)
                {
                    _SafeStr_1376.removeChild(COLOUR_WINDOW);
                };
            };
            if (((!(_editor.manager == null)) && (!(_editor.manager.sessionData == null))))
            {
                _SafeStr_1376.findChildByName("avatar_name").caption = _editor.manager.sessionData.userName;
                if (_editor.manager.getBoolean("premium.name.change.enabled"))
                {
                    _SafeStr_1376.findChildByName("avatar_name_change").visible = true;
                };
            };
            _SafeStr_1376.procedure = windowEventProc;
            _SafeStr_1378 = (_SafeStr_1376.findChildByName("mainTabs") as ITabContextWindow);
            var _local_1:Vector.<String> = new Vector.<String>(0);
            _local_4 = (_SafeStr_1378.numTabItems - 1);
            while (_local_4 >= 0)
            {
                _local_3 = _SafeStr_1378.getTabItemAt(_local_4);
                _local_1.push(_local_3.name);
                if (((!(_local_3 == null)) && (_SafeStr_1375.indexOf(_local_3.name) < 0)))
                {
                    _SafeStr_1378.removeTabItem(_local_3);
                    _local_5 = (_local_4 + 1);
                    while (_local_5 < _SafeStr_1378.numTabItems)
                    {
                        _SafeStr_1378.getTabItemAt(_local_5).x = (_SafeStr_1378.getTabItemAt(_local_5).x - _local_3.width);
                        _local_5++;
                    };
                };
                _local_4--;
            };
            _categoryContainers = new Dictionary();
            var _local_2:IWindowContainer = (_SafeStr_1376.findChildByName("contentArea") as IWindowContainer);
            for each (var _local_6:String in _local_1)
            {
                _local_7 = _local_2.findChildByName((_local_6 + "_content"));
                if (_local_7)
                {
                    _categoryContainers[_local_6] = _local_2.removeChild(_local_7);
                };
            };
            _gridView = new AvatarEditorGridView((_SafeStr_1376.findChildByName("grid_container") as IWindowContainer));
            _effectsGridView = new AvatarEditorGridViewEffects((_SafeStr_1376.findChildByName("grid_container") as IWindowContainer));
            _SafeStr_1378.selector.setSelected(_SafeStr_1378.getTabItemAt(0));
            update();
        }

        public function update():void
        {
            var _local_1:IWindow = (_SafeStr_1376.findChildByName("wardrobeButtonContainer") as IWindow);
            if (((_local_1) && (_editor.manager.sessionData)))
            {
                _local_1.visible = ((_editor.manager.sessionData.hasClub) && (_editor.isSideContentEnabled()));
                _local_1.visible = _editor.isSideContentEnabled();
            };
            var _local_2:String = "nothing";
            if (((_SafeStr_1380 == "wardrobe") || (_showWardrobeOnUpdate)))
            {
                _local_2 = "wardrobe";
            };
            if (!_editor.isSideContentEnabled())
            {
                _local_2 = "nothing";
            };
            if (_editor.hasInvalidClubItems())
            {
                _editor.stripClubItems();
                _editor.disableClubClothing();
            };
            if (_editor.hasInvalidSellableItems())
            {
                _editor.stripInvalidSellableItems();
            };
            setSideContent(_local_2);
            setViewToCategory(_SafeStr_1377);
        }

        public function toggleCategoryView(_arg_1:String, _arg_2:Boolean=false):void
        {
            if (_arg_2)
            {
            };
            setViewToCategory(_arg_1);
        }

        private function toggleWardrobe():void
        {
            if (_SafeStr_1380 == "wardrobe")
            {
                _showWardrobeOnUpdate = false;
                setSideContent("nothing");
            }
            else
            {
                setSideContent("wardrobe");
            };
        }

        private function setSideContent(_arg_1:String):void
        {
            var _local_5:int;
            if (_SafeStr_1380 == _arg_1)
            {
                return;
            };
            var _local_2:IWindowContainer = (_SafeStr_1376.findChildByName("sideContainer") as IWindowContainer);
            if (!_local_2)
            {
                return;
            };
            var _local_4:IWindow;
            switch (_arg_1)
            {
                case "nothing":
                    break;
                case "wardrobe":
                    _local_4 = _editor.getSideContentWindowContainer("wardrobe");
            };
            var _local_3:IWindow = _local_2.removeChildAt(0);
            if (_local_3)
            {
                _SafeStr_1376.width = (_SafeStr_1376.width - _local_3.width);
            };
            if (_local_4)
            {
                _local_2.addChild(_local_4);
                _local_4.visible = true;
                _local_2.width = _local_4.width;
            }
            else
            {
                _local_2.width = 0;
            };
            _SafeStr_1380 = _arg_1;
            if (_SafeStr_1379)
            {
                _local_5 = 8;
                _SafeStr_1379.content.width = (_SafeStr_1376.width + _local_5);
            };
        }

        private function setViewToCategory(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1 == "")
            {
                return;
            };
            var _local_2:IWindowContainer = (_SafeStr_1376.findChildByName("contentArea") as IWindowContainer);
            if (_local_2 == null)
            {
                return;
            };
            if (_arg_1 == "effects")
            {
                effectsParamViewContainer.visible = true;
            }
            else
            {
                effectsParamViewContainer.visible = false;
            };
            var _local_4:IWindow = _local_2.getChildAt(0);
            _local_2.removeChild(_local_4);
            _local_2.invalidate();
            var _local_3:IWindow = _editor.getCategoryWindowContainer(_arg_1);
            if (_local_3 == null)
            {
                return;
            };
            _gridView.window.visible = false;
            _local_3.visible = true;
            _local_2.addChild(_local_3);
            _editor.activateCategory(_arg_1);
            _SafeStr_1377 = _arg_1;
            _SafeStr_1378.selector.setSelected(_SafeStr_1378.getTabItemByName(_arg_1));
        }

        public function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:String;
            if (_arg_1.type == "WE_SELECTED")
            {
                _local_3 = (_arg_2 as ITabContextWindow).selector.getSelected().name;
                if (_local_3 != _SafeStr_1377)
                {
                    _editor.toggleAvatarEditorPage(_local_3);
                };
            }
            else
            {
                if (_arg_1.type == "WME_CLICK")
                {
                    switch (_arg_2.name)
                    {
                        case "save":
                            if (((!(_editor.isDevelopmentEditor())) && (_editor.hasInvalidSellableItems())))
                            {
                                startSellablePurchase();
                                _SafeStr_1373.start();
                                _SafeStr_1376.findChildByName("save").disable();
                                return;
                            };
                            if (((!(_editor.isDevelopmentEditor())) && (_editor.hasInvalidClubItems())))
                            {
                                _editor.openHabboClubAdWindow();
                                _SafeStr_1373.start();
                                _SafeStr_1376.findChildByName("save").disable();
                                return;
                            };
                            _SafeStr_1373.start();
                            _SafeStr_1376.findChildByName("save").disable();
                            _editor.saveCurrentSelection();
                            _editor.manager.close(_editor.instanceId);
                            return;
                        case "cancel":
                        case "header_button_close":
                            if (_editor.hasInvalidClubItems())
                            {
                                _editor.stripClubItems();
                                _editor.disableClubClothing();
                            };
                            _editor.manager.close(_editor.instanceId);
                            return;
                        case "rotate_avatar":
                            _avatarDirection++;
                            if (_avatarDirection > 7)
                            {
                                _avatarDirection = 0;
                            };
                            _editor.figureData.direction = _avatarDirection;
                            return;
                        case "wardrobe":
                            toggleWardrobe();
                            return;
                        case "avatar_name_change":
                            if (_avatarEditorNameChangeView != null)
                            {
                                _avatarEditorNameChangeView.focus();
                            }
                            else
                            {
                                _avatarEditorNameChangeView = new AvatarEditorNameChangeView(this, (_SafeStr_1376.x + _SafeStr_1376.width), _SafeStr_1376.y);
                            };
                            return;
                    };
                };
            };
        }

        private function startSellablePurchase():void
        {
            if (_editor.manager.catalog)
            {
                _editor.manager.catalog.openCatalogPage(_editor.manager.getProperty("catalog.clothes.page"));
            };
        }

        public function get effectsParamViewContainer():IWindowContainer
        {
            return (IWindowContainer(_SafeStr_1376.findChildByName("effectParamsContainer")));
        }

        public function getCategoryContainer(_arg_1:String):IWindow
        {
            return (_categoryContainers[_arg_1]);
        }

        public function get gridView():IAvatarEditorGridView
        {
            return (_gridView);
        }

        public function getFigureContainer():IWidgetWindow
        {
            return (_SafeStr_1376.findChildByName("avatarWidget") as IWidgetWindow);
        }

        public function get effectsGridView():IAvatarEditorGridView
        {
            return (_effectsGridView);
        }

        public function get editor():HabboAvatarEditor
        {
            return (_editor);
        }

        public function get avatarEditorNameChangeView():AvatarEditorNameChangeView
        {
            return (_avatarEditorNameChangeView);
        }


    }
}

