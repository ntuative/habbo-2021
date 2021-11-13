package com.sulake.habbo.window.utils.floorplaneditor
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.HabboWindowManagerComponent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.FloorHeightMapMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomEntryTileMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomOccupiedTilesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageEvent;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageParser;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.outgoing.room.layout._SafeStr_33;
    import com.sulake.habbo.communication.messages.outgoing.room.layout._SafeStr_44;
    import flash.utils.ByteArray;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.InteractiveController;
    import com.sulake.core.window.components._SafeStr_108;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.layout.UpdateFloorPropertiesMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.events.KeyboardEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.parser.room.layout.RoomEntryTileMessageParser;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomVisualizationSettingsParser;
    import com.sulake.habbo.communication.messages.parser.perk.PerkAllowancesMessageParser;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import __AS3__.vec.Vector;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.room.events.RoomEngineEvent;

    public class BCFloorPlanEditor implements IUpdateReceiver 
    {

        private static const PREVIEW_UPDATE_MS:uint = 2000;
        private static const WALL_HEIGHT_LIMIT:int = 16;

        public static var floor_plan_editor_layout:Class = HabboBCFloorPlanEditor_Habbofloor_plan_editor_layout_xml;
        public static var floor_plan_editor_export_import:Class = HabboBCFloorPlanEditor_Habbofloor_plan_editor_export_import_xml;

        private var _windowManager:HabboWindowManagerComponent;
        private var _floorHeightMapMessageEvent:FloorHeightMapMessageEvent;
        private var _entryTileDataMessageEvent:RoomEntryTileMessageEvent;
        private var _occupiedTilesMessageEvent:RoomOccupiedTilesMessageEvent;
        private var _roomVisualizationSettingsMessageEvent:RoomVisualizationSettingsEvent;
        private var _buildersClubSubscriptionStatusMessageEvent:BuildersClubSubscriptionStatusMessageEvent;
        private var _perkAllowancesMessageEvent:PerkAllowancesMessageEvent;
        private var _floorPlanCache:FloorPlanCache;
        private var _floorPlanPreviewer:FloorPlanPreviewer;
        private var _heightMapEditor:HeightMapEditor;
        private var _importExportDialog:ImportExportDialog;
        private var _lastReceivedMapEvent:FloorHeightMapMessageEvent;
        private var _editorWindow:IFrameWindow;
        private var _drawModes:Array = ["add_tile", "remove_tile", "increase_height", "decrease_height", "set_enter_tile"];
        private var _drawMode:String = _drawModes[0];
        private var _floorThickness:int;
        private var _wallThickness:int;
        private var _msSinceLastPreviewUpdate:uint;
        private var _bcSecondsLeft:int = 0;
        private var _bcSecondsCountdownTimer:Timer;
        private var _largeFloorPlansAllowed:Boolean = false;
        private var _fixedWallsHeight:int;
        private var _colorMapMouseDown:Boolean = false;
        private var _wallHeightSliderMouseDown:Boolean = false;

        public function BCFloorPlanEditor(_arg_1:HabboWindowManagerComponent)
        {
            _floorPlanCache = new FloorPlanCache(this);
            _windowManager = _arg_1;
            if (_windowManager.communication != null)
            {
                _floorHeightMapMessageEvent = new FloorHeightMapMessageEvent(onFloorHeightMap);
                _entryTileDataMessageEvent = new RoomEntryTileMessageEvent(onEntryTileData);
                _occupiedTilesMessageEvent = new RoomOccupiedTilesMessageEvent(onOccupiedTiles);
                _roomVisualizationSettingsMessageEvent = new RoomVisualizationSettingsEvent(onRoomVisualizationSettings);
                _buildersClubSubscriptionStatusMessageEvent = new BuildersClubSubscriptionStatusMessageEvent(onBcStatus);
                _perkAllowancesMessageEvent = new PerkAllowancesMessageEvent(onPerkAllowances);
                _windowManager.communication.addHabboConnectionMessageEvent(_floorHeightMapMessageEvent);
                _windowManager.communication.addHabboConnectionMessageEvent(_buildersClubSubscriptionStatusMessageEvent);
                _windowManager.communication.addHabboConnectionMessageEvent(_entryTileDataMessageEvent);
                _windowManager.communication.addHabboConnectionMessageEvent(_occupiedTilesMessageEvent);
                _windowManager.communication.addHabboConnectionMessageEvent(_roomVisualizationSettingsMessageEvent);
                _windowManager.communication.addHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
            };
            if (_arg_1.roomEngine)
            {
                _arg_1.roomEngine.events.addEventListener("REE_DISPOSED", onRoomDisposed);
            };
            _arg_1.registerUpdateReceiver(this, 0);
        }

        public static function getThicknessSettingBySelectionIndex(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (-2);
                case 1:
                    return (-1);
                case 3:
                    return (1);
                default:
                    return (0);
            };
        }


        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_floorHeightMapMessageEvent != null)
            {
                _windowManager.communication.removeHabboConnectionMessageEvent(_floorHeightMapMessageEvent);
                _windowManager.communication.removeHabboConnectionMessageEvent(_entryTileDataMessageEvent);
                _windowManager.communication.removeHabboConnectionMessageEvent(_occupiedTilesMessageEvent);
                _windowManager.communication.removeHabboConnectionMessageEvent(_roomVisualizationSettingsMessageEvent);
                _windowManager.communication.removeHabboConnectionMessageEvent(_buildersClubSubscriptionStatusMessageEvent);
                _windowManager.communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
                _floorHeightMapMessageEvent = null;
                _entryTileDataMessageEvent = null;
                _occupiedTilesMessageEvent = null;
                _roomVisualizationSettingsMessageEvent = null;
            };
            if (((windowManager.roomEngine) && (!(windowManager.roomEngine.disposed))))
            {
                windowManager.roomEngine.events.removeEventListener("REE_DISPOSED", onRoomDisposed);
            };
            _windowManager.removeUpdateReceiver(this);
            _windowManager = null;
        }

        public function get disposed():Boolean
        {
            return (_windowManager == null);
        }

        private function onBcStatus(_arg_1:BuildersClubSubscriptionStatusMessageEvent):void
        {
            var _local_2:BuildersClubSubscriptionStatusMessageParser = _arg_1.getParser();
            _bcSecondsLeft = _local_2.secondsLeft;
            if (!_bcSecondsCountdownTimer)
            {
                _bcSecondsCountdownTimer = new Timer(10000);
                _bcSecondsCountdownTimer.addEventListener("timer", onBcCountdownTimerEvent);
                _bcSecondsCountdownTimer.start();
            };
        }

        private function onBcCountdownTimerEvent(_arg_1:TimerEvent):void
        {
            _bcSecondsLeft = (_bcSecondsLeft - 10);
            if (((_editorWindow) && (_editorWindow.visible)))
            {
                if (((_bcSecondsLeft > 0) || (_windowManager.sessionDataManager.hasSecurity(4))))
                {
                    _editorWindow.findChildByName("save").enable();
                }
                else
                {
                    _editorWindow.findChildByName("save").disable();
                };
            };
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (((_editorWindow == null) || (_editorWindow.disposed)))
            {
                createEditorWindow();
            };
            _editorWindow.visible = _arg_1;
            if (_arg_1)
            {
                _windowManager.communication.connection.send(new _SafeStr_33());
                _windowManager.communication.connection.send(new _SafeStr_44());
                updateThicknessSelection();
                centerScrollableViews();
                updateWallHeight(_fixedWallsHeight);
            }
            else
            {
                _heightMapEditor.colorPickMode = false;
            };
        }

        public function get visible():Boolean
        {
            return ((!(_editorWindow == null)) && (_editorWindow.visible));
        }

        private function createEditorWindow():void
        {
            var _local_1:ByteArray = (new floor_plan_editor_layout() as ByteArray);
            var _local_2:XML = new XML(_local_1.readUTFBytes(_local_1.length));
            _editorWindow = (_windowManager.buildFromXML(_local_2, 1) as IFrameWindow);
            _editorWindow.procedure = editorWindowProcedure;
            _editorWindow.findChildByName("tile_height_colormap").procedure = colorMapWindowProcedure;
            _editorWindow.findChildByName("wall_height_slider").procedure = wallHeightSliderProcedure;
            _editorWindow.center();
            _floorPlanPreviewer = new FloorPlanPreviewer(this);
            _heightMapEditor = new HeightMapEditor(this);
            _local_1 = (new floor_plan_editor_export_import() as ByteArray);
            _importExportDialog = new ImportExportDialog(this, new XML(_local_1.readUTFBytes(_local_1.length)));
            _floorPlanPreviewer.updatePreview();
            _heightMapEditor.refreshFromCache();
            createTileHeightColorMap(_heightMapEditor.heigthColorMap);
            setDrawMode("add_tile");
            IItemListWindow(_editorWindow.findChildByName("heightmap_wrapper")).disableAutodrag = true;
            IItemListWindow(_editorWindow.findChildByName("preview_wrapper")).disableAutodrag = true;
            if (((!(_windowManager.sessionDataManager.hasSecurity(4))) && (_bcSecondsLeft <= 0)))
            {
                _editorWindow.findChildByName("save").disable();
            };
        }

        public function update(_arg_1:uint):void
        {
            if (((!(_drawMode == "")) && (_editorWindow)))
            {
                for each (var _local_2:String in _drawModes)
                {
                    if (_drawMode == _local_2)
                    {
                        InteractiveController(_editorWindow.findChildByName(_local_2)).state = (InteractiveController(_editorWindow.findChildByName(_local_2)).state | 0x10);
                    }
                    else
                    {
                        InteractiveController(_editorWindow.findChildByName(_local_2)).state = (InteractiveController(_editorWindow.findChildByName(_local_2)).state & (~(0x10)));
                    };
                };
            };
            _msSinceLastPreviewUpdate = (_msSinceLastPreviewUpdate + _arg_1);
            if (((_msSinceLastPreviewUpdate > 2000) && (_floorPlanPreviewer)))
            {
                _floorPlanPreviewer.updatePreview();
                _msSinceLastPreviewUpdate = 0;
            };
        }

        private function get isWallHeightSettingSelected():Boolean
        {
            return (_SafeStr_108(_editorWindow.findChildByName("walls_fixed_height_enabled_checkbox")).isSelected);
        }

        private function editorWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                    case "cancel":
                        visible = false;
                        break;
                    case "refresh":
                        _floorPlanPreviewer.updatePreview();
                        break;
                    case "save":
                        _floorThickness = IDropMenuWindow(_editorWindow.findChildByName("floor_thickness_drop")).selection;
                        _wallThickness = IDropMenuWindow(_editorWindow.findChildByName("wall_thickness_drop")).selection;
                        _windowManager.communication.connection.send(new UpdateFloorPropertiesMessageComposer(_floorPlanCache.getData(), _floorPlanCache.entryPoint.x, _floorPlanCache.entryPoint.y, _floorPlanCache.entryPointDir, getThicknessSettingBySelectionIndex(_wallThickness), getThicknessSettingBySelectionIndex(_floorThickness), ((isWallHeightSettingSelected) ? _fixedWallsHeight : -1)));
                        break;
                    case "reload":
                        _floorPlanCache.onFloorHeightMap(_lastReceivedMapEvent);
                        if (_floorPlanPreviewer)
                        {
                            _floorPlanPreviewer.updatePreview();
                        };
                        if (_heightMapEditor)
                        {
                            _heightMapEditor.refreshFromCache();
                        };
                        _windowManager.communication.connection.send(new _SafeStr_44());
                        _windowManager.communication.connection.send(new _SafeStr_33());
                        break;
                    case "import_export":
                        _importExportDialog.visible = (!(_importExportDialog.visible));
                        break;
                    case "enterdirection_left":
                        _floorPlanCache.entryPointDir++;
                        updateEntryDirectionAvatar();
                        break;
                    case "enterdirection_right":
                        _floorPlanCache.entryPointDir--;
                        updateEntryDirectionAvatar();
                        break;
                    case "zoom":
                        if (_heightMapEditor.zoomLevel == 1)
                        {
                            _heightMapEditor.zoomLevel = 2;
                        }
                        else
                        {
                            _heightMapEditor.zoomLevel = 1;
                        };
                        _heightMapEditor.refreshFromCache();
                        break;
                    case "walls_fixed_height_enabled_checkbox":
                        enableWallHeightControls(isWallHeightSettingSelected);
                        if (((isWallHeightSettingSelected) && (_fixedWallsHeight == -1)))
                        {
                            _fixedWallsHeight = (parseInt(_editorWindow.findChildByName("wall_height_number").caption) - 1);
                        };
                };
                if (_drawModes.indexOf(_arg_2.name) != -1)
                {
                    setDrawMode(_arg_2.name);
                };
            };
        }

        public function onKeyboardEvent(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.type == "keyDown")
            {
                switch (_arg_1.keyCode)
                {
                    case 107:
                        _heightMapEditor.drawingHeight++;
                        break;
                    case 109:
                        _heightMapEditor.drawingHeight++;
                        break;
                    case 16:
                        if (_heightMapEditor)
                        {
                            _heightMapEditor.colorPickMode = true;
                        };
                };
            }
            else
            {
                if (_arg_1.type == "keyUp")
                {
                    if (_arg_1.keyCode == 16)
                    {
                        if (_heightMapEditor)
                        {
                            _heightMapEditor.colorPickMode = false;
                        };
                    };
                };
            };
        }

        private function setDrawMode(_arg_1:String):void
        {
            _drawMode = _arg_1;
        }

        private function colorMapWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowMouseEvent;
            var _local_4:uint;
            if (_arg_1.type == "WME_DOWN")
            {
                _colorMapMouseDown = true;
            }
            else
            {
                if (((_arg_1.type == "WME_UP") || (_arg_1.type == "WME_UP_OUTSIDE")))
                {
                    _colorMapMouseDown = false;
                }
                else
                {
                    if (((_arg_1.type == "WME_CLICK") || ((_colorMapMouseDown) && (_arg_1.type == "WME_MOVE"))))
                    {
                        _local_3 = (_arg_1 as WindowMouseEvent);
                        _local_4 = uint(((_local_3.localX / _editorWindow.findChildByName("tile_height_colormap").width) * _heightMapEditor.heigthColorMap.length));
                        updateColorSliderTrack(_local_4);
                        _heightMapEditor.drawingHeight = _local_4;
                    };
                };
            };
        }

        public function updateColorSliderTrack(_arg_1:uint):void
        {
            _editorWindow.findChildByName("tile_height_slider_track").x = (_arg_1 * (_editorWindow.findChildByName("tile_height_colormap").width / _heightMapEditor.heigthColorMap.length));
        }

        private function wallHeightSliderProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowMouseEvent;
            var _local_4:uint;
            if (_arg_1.type == "WME_DOWN")
            {
                _wallHeightSliderMouseDown = true;
            }
            else
            {
                if (((_arg_1.type == "WME_UP") || (_arg_1.type == "WME_UP_OUTSIDE")))
                {
                    _wallHeightSliderMouseDown = false;
                }
                else
                {
                    if (((_arg_1.type == "WME_CLICK") || ((_wallHeightSliderMouseDown) && (_arg_1.type == "WME_MOVE"))))
                    {
                        _local_3 = (_arg_1 as WindowMouseEvent);
                        _local_4 = uint(((_local_3.localX / _editorWindow.findChildByName("wall_height_slider").width) * 16));
                        updateWallHeight(_local_4);
                        _fixedWallsHeight = _local_4;
                    };
                };
            };
            _arg_1.stopPropagation();
        }

        public function updateWallHeight(_arg_1:int):void
        {
            if (_arg_1 == -1)
            {
                _SafeStr_108(_editorWindow.findChildByName("walls_fixed_height_enabled_checkbox")).unselect();
                enableWallHeightControls(false);
            }
            else
            {
                _SafeStr_108(_editorWindow.findChildByName("walls_fixed_height_enabled_checkbox")).select();
                enableWallHeightControls(true);
                _editorWindow.findChildByName("wall_height_number").caption = (_arg_1 + 1).toString();
                _editorWindow.findChildByName("wall_height_slider_track").x = (_arg_1 * (_editorWindow.findChildByName("wall_height_slider").width / 16));
            };
        }

        private function enableWallHeightControls(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                _editorWindow.findChildByName("wall_height_text").enable();
                _editorWindow.findChildByName("wall_height_number").enable();
                _editorWindow.findChildByName("wall_height_slider").enable();
                _editorWindow.findChildByName("wall_height_slider_track").enable();
                _editorWindow.findChildByName("wall_height_text").blend = 1;
                _editorWindow.findChildByName("wall_height_number").blend = 1;
                _editorWindow.findChildByName("wall_height_slider").blend = 1;
                _editorWindow.findChildByName("wall_height_slider_track").blend = 1;
            }
            else
            {
                _editorWindow.findChildByName("wall_height_text").disable();
                _editorWindow.findChildByName("wall_height_number").disable();
                _editorWindow.findChildByName("wall_height_slider").disable();
                _editorWindow.findChildByName("wall_height_slider_track").disable();
                _editorWindow.findChildByName("wall_height_text").blend = 0.6;
                _editorWindow.findChildByName("wall_height_number").blend = 0.6;
                _editorWindow.findChildByName("wall_height_slider").blend = 0.6;
                _editorWindow.findChildByName("wall_height_slider_track").blend = 0.6;
            };
        }

        private function onFloorHeightMap(_arg_1:FloorHeightMapMessageEvent):void
        {
            _lastReceivedMapEvent = _arg_1;
            _floorPlanCache.onFloorHeightMap(_arg_1);
            _fixedWallsHeight = _arg_1.getParser().fixedWallsHeight;
            if (_floorPlanPreviewer)
            {
                _floorPlanPreviewer.updatePreview();
            };
            if (_heightMapEditor)
            {
                _heightMapEditor.refreshFromCache();
            };
            if (_editorWindow)
            {
                updateWallHeight(_fixedWallsHeight);
            };
        }

        private function onEntryTileData(_arg_1:RoomEntryTileMessageEvent):void
        {
            if (!_editorWindow)
            {
                return;
            };
            var _local_2:RoomEntryTileMessageParser = _arg_1.getParser();
            _floorPlanCache.entryPoint = new Point(_local_2.x, _local_2.y);
            _floorPlanCache.entryPointDir = _local_2.dir;
            if (_heightMapEditor)
            {
                _heightMapEditor.refreshFromCache();
            };
            updateEntryDirectionAvatar();
        }

        private function onOccupiedTiles(_arg_1:RoomOccupiedTilesMessageEvent):void
        {
            _floorPlanCache.onOccupiedTiles(_arg_1);
            if (_heightMapEditor)
            {
                _heightMapEditor.refreshFromCache();
            };
        }

        private function onRoomVisualizationSettings(_arg_1:RoomVisualizationSettingsEvent):void
        {
            var _local_2:RoomVisualizationSettingsParser = _arg_1.getParser();
            _floorThickness = getThicknessSelectionIndex(_local_2.floorThicknessMultiplier);
            _wallThickness = getThicknessSelectionIndex(_local_2.wallThicknessMultiplier);
            updateThicknessSelection();
        }

        private function onPerkAllowances(_arg_1:PerkAllowancesMessageEvent):void
        {
            var _local_2:PerkAllowancesMessageParser = _arg_1.getParser();
            _largeFloorPlansAllowed = _local_2.isPerkAllowed("BUILDER_AT_WORK");
        }

        public function updatePreviewBitmap(_arg_1:BitmapData):void
        {
            var _local_2:IBitmapWrapperWindow = IBitmapWrapperWindow(_editorWindow.findChildByName("preview_bitmap"));
            _local_2.bitmap = _arg_1;
        }

        private function createTileHeightColorMap(_arg_1:Vector.<Array>):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:uint;
            var _local_6:IBitmapWrapperWindow = (_editorWindow.findChildByName("tile_height_colormap") as IBitmapWrapperWindow);
            _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, false, 0);
            var _local_3:Rectangle = new Rectangle(0, 0, 1, _local_6.height);
            _local_4 = 0;
            while (_local_4 < _local_6.width)
            {
                _local_5 = int(((_local_4 / _local_6.width) * _arg_1.length));
                _local_2 = ((((0xFF * _arg_1[_local_5][0]) << 16) + ((0xFF * _arg_1[_local_5][1]) << 8)) + (0xFF * _arg_1[_local_5][2]));
                _local_3.x = _local_4;
                _local_6.bitmap.fillRect(_local_3, _local_2);
                _local_4++;
            };
        }

        private function updateEntryDirectionAvatar():void
        {
            var _local_1:IAvatarImageWidget = (IWidgetWindow(_editorWindow.findChildByName("enterdirection_ghost_avatar")).widget as IAvatarImageWidget);
            _local_1.direction = _floorPlanCache.entryPointDir;
        }

        private function getThicknessSelectionIndex(_arg_1:Number):int
        {
            switch (_arg_1)
            {
                case 0.25:
                    return (0);
                case 0.5:
                    return (1);
                case 2:
                    return (3);
                default:
                    return (2);
            };
        }

        private function updateThicknessSelection():void
        {
            if (_editorWindow)
            {
                IDropMenuWindow(_editorWindow.findChildByName("wall_thickness_drop")).selection = _wallThickness;
                IDropMenuWindow(_editorWindow.findChildByName("floor_thickness_drop")).selection = _floorThickness;
            };
        }

        private function centerScrollableViews():void
        {
            var _local_1:IScrollbarWindow = (_editorWindow.findChildByName("heightmap_scroll_horizontal") as IScrollbarWindow);
            var _local_2:IScrollbarWindow = (_editorWindow.findChildByName("heightmap_scroll_vertical") as IScrollbarWindow);
            var _local_4:IScrollbarWindow = (_editorWindow.findChildByName("preview_scroll_horizontal") as IScrollbarWindow);
            var _local_3:IScrollbarWindow = (_editorWindow.findChildByName("preview_scroll_vertical") as IScrollbarWindow);
            _local_1.scrollH = 0.5;
            _local_2.scrollV = 0.5;
            _local_4.scrollH = 0.5;
            _local_3.scrollV = 0.5;
        }

        private function onRoomDisposed(_arg_1:RoomEngineEvent):void
        {
            visible = false;
        }

        public function get windowManager():HabboWindowManagerComponent
        {
            return (_windowManager);
        }

        public function get heightMapBitmapElement():IBitmapWrapperWindow
        {
            return (_editorWindow.findChildByName("heightmap_bitmap") as IBitmapWrapperWindow);
        }

        public function get floorPlanCache():FloorPlanCache
        {
            return (_floorPlanCache);
        }

        public function get drawModes():Array
        {
            return (_drawModes);
        }

        public function get drawMode():String
        {
            return (_drawMode);
        }

        public function get heightMapEditor():HeightMapEditor
        {
            return (_heightMapEditor);
        }

        public function get largeFloorPlansAllowed():Boolean
        {
            return (_largeFloorPlansAllowed);
        }

        public function get lastReceivedFloorPlan():String
        {
            if (_lastReceivedMapEvent)
            {
                return (_lastReceivedMapEvent.getParser().text);
            };
            return ("");
        }

        public function get floorThickness():int
        {
            return (_floorThickness);
        }

        public function get wallThickness():int
        {
            return (_wallThickness);
        }

        public function get bcSecondsLeft():int
        {
            return (_bcSecondsLeft);
        }


    }
}

