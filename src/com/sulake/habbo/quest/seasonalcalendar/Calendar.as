package com.sulake.habbo.quest.seasonalcalendar
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.quest.HabboQuestEngine;
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.core.assets.IAsset;
    import flash.events.TimerEvent;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components._SafeStr_124;
    import com.sulake.core.window.components.ITextWindow;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class Calendar implements IDisposable, IUpdateReceiver
    {

        private static const BG_IMAGE_PREFIX:String = "background_";
        private static const ENTITY_IMAGE_PREFIX:String = "day";
        private static const ENTITY_IMAGE_UNCOMPLETE_POSTFIX:String = "_uncomplete";
        private static const ENTITY_IMAGE_COMPLETED_POSTFIX:String = "_completed";
        private static const SHOW_FUTURE_INACTIVE_ENTITIES_COUNT:int = 2;
        private static const _SafeStr_3058:int = 3;
        private static const ENTITY_SPACING:int = 80;
        private static const ENTITIES_LEFT_MARGIN:int = 37;
        private static const _SafeStr_3059:int = 7;
        private static const DAILY_REFRESH_DELAY_MINUTES:int = 5;
        private static const FLASH_PULSE_LENGHT_IN_MS:int = 2000;
        private static const FLASH_MAX_BRIGHTNESS:int = 100;

        private var _questEngine:HabboQuestEngine;
        private var _SafeStr_2554:MainWindow;
        private var _SafeStr_3060:Array;
        private var _backgroundImageCache:Vector.<BitmapData>;
        private var _graphicEntityCache:Vector.<BitmapData>;
        private var _SafeStr_3061:Map;
        private var _bgAssetNameArray:Array;
        private var _SafeStr_3062:String;
        private var _SafeStr_3063:CalendarBackgroundRenderer;
        private var _entityWindows:Vector.<IWindowContainer>;
        private var _states:Array;
        private var _SafeStr_3064:CalendarArrowButton;
        private var _SafeStr_3065:CalendarArrowButton;
        private var _SafeStr_3066:IWindowContainer;
        private var _SafeStr_3067:IWindowContainer;
        private var _SafeStr_3068:IBitmapWrapperWindow;
        private var _SafeStr_3069:int = -1;
        private var _SafeStr_3070:int = -1;
        private var _highestAvailableQuestIndex:int = -1;
        private var _SafeStr_3071:int = 42;
        private var _SafeStr_3072:Timer;
        private var _scrollOffset:int = 0;
        private var _SafeStr_3073:int = 0;
        private var _scrollBgStartOffset:int = 0;
        private var _SafeStr_3074:int = -1;
        private var _SafeStr_3075:int;
        private var _SafeStr_3076:int = -1;
        private var _SafeStr_3077:Boolean = false;
        private var _SafeStr_3078:Boolean = false;
        private var _SafeStr_3079:Timer;
        private var _SafeStr_3080:int = -1;

        public function Calendar(_arg_1:HabboQuestEngine, _arg_2:MainWindow)
        {
            _questEngine = _arg_1;
            _SafeStr_2554 = _arg_2;
        }

        private static function adjustBrightness(_arg_1:uint, _arg_2:int):uint
        {
            var _local_3:int = Math.min(0xFF, Math.max(0, (((_arg_1 >> 16) & 0xFF) + _arg_2)));
            var _local_5:int = Math.min(0xFF, Math.max(0, (((_arg_1 >> 8) & 0xFF) + _arg_2)));
            var _local_4:int = Math.min(0xFF, Math.max(0, ((_arg_1 & 0xFF) + _arg_2)));
            return ((((_local_3 & 0xFF) << 16) + ((_local_5 & 0xFF) << 8)) + (_local_4 & 0xFF));
        }


        private function getImageGalleryHost():String
        {
            return (_SafeStr_3062);
        }

        public function dispose():void
        {
            if (!disposed)
            {
                _questEngine.removeUpdateReceiver(this);
                cleanUpEntityWindows();
                if (_SafeStr_3063 != null)
                {
                    _SafeStr_3063.dispose();
                    _SafeStr_3063 = null;
                };
                if (_SafeStr_3064 != null)
                {
                    _SafeStr_3064.dispose();
                    _SafeStr_3064 = null;
                };
                if (_SafeStr_3065 != null)
                {
                    _SafeStr_3065.dispose();
                    _SafeStr_3065 = null;
                };
                if (_SafeStr_3072 != null)
                {
                    _SafeStr_3072.stop();
                    _SafeStr_3072 = null;
                };
                if (_SafeStr_3079 != null)
                {
                    _SafeStr_3079.stop();
                    _SafeStr_3079 = null;
                };
                _backgroundImageCache = null;
                _graphicEntityCache = null;
                _states = null;
                _SafeStr_3061 = null;
                _bgAssetNameArray = null;
                _questEngine = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        public function onQuests(_arg_1:Array):void
        {
            var _local_4:Date = new Date();
            _SafeStr_3080 = _local_4.getDate();
            var _local_2:int = _SafeStr_3070;
            _SafeStr_3060 = [];
            _highestAvailableQuestIndex = 0;
            var _local_3:QuestMessageData;
            for each (_local_3 in _arg_1)
            {
                if (_questEngine.isSeasonalQuest(_local_3))
                {
                    _SafeStr_3060.push(_local_3);
                    if (_highestAvailableQuestIndex < (_local_3.sortOrder - 1))
                    {
                        _highestAvailableQuestIndex = (_local_3.sortOrder - 1);
                    };
                };
            };
            _SafeStr_3060.sortOn(["sortOrder"]);
            _SafeStr_3071 = int(_questEngine.configuration.getProperty("seasonalQuestCalendar.maximum.entities"));
            _SafeStr_3070 = Math.min(_SafeStr_3071, ((_highestAvailableQuestIndex + 1) + 2));
            if (((!(_local_2 == -1)) && (_SafeStr_3070 > _local_2)))
            {
                prepareImages();
            };
        }

        public function prepare(_arg_1:IFrameWindow):void
        {
            var _local_2:IBitmapWrapperWindow;
            _SafeStr_3062 = _SafeStr_2554.getCalendarImageGalleryHost();
            _SafeStr_3066 = IWindowContainer(_arg_1.findChildByName("calendar_cont"));
            _SafeStr_3068 = IBitmapWrapperWindow(_arg_1.findChildByName("background_slice"));
            _SafeStr_3067 = IWindowContainer(_arg_1.findChildByName("entity_template"));
            _SafeStr_3067.visible = false;
            _SafeStr_3063 = new CalendarBackgroundRenderer();
            _SafeStr_3064 = new CalendarArrowButton(_questEngine.assets, IBitmapWrapperWindow(_arg_1.findChildByName("button_left")), 0, scrollArrowProcedure);
            _SafeStr_3065 = new CalendarArrowButton(_questEngine.assets, IBitmapWrapperWindow(_arg_1.findChildByName("button_right")), 1, scrollArrowProcedure);
            _local_2 = IBitmapWrapperWindow(_arg_1.findChildByName("stripe_mask_left"));
            _local_2.bitmap = BitmapData(IAsset(_questEngine.assets.getAssetByName("stripe_mask_L")).content);
            _local_2 = IBitmapWrapperWindow(_arg_1.findChildByName("stripe_mask_right"));
            _local_2.bitmap = BitmapData(IAsset(_questEngine.assets.getAssetByName("stripe_mask_R")).content);
            if (_SafeStr_3069 == -1)
            {
                goToDay(_SafeStr_2554.currentDay);
            };
            prepareImages();
            var _local_3:Date = new Date();
            _SafeStr_3080 = _local_3.getDate();
            _SafeStr_3079 = new Timer((60000 * 5));
            _SafeStr_3079.addEventListener("timer", onDateRefreshTimer);
            _SafeStr_3079.start();
            onDateRefreshTimer(new TimerEvent("timer"));
            _questEngine.registerUpdateReceiver(this, 1);
            _SafeStr_3072 = new Timer(10, 10);
        }

        public function close():void
        {
            cleanUpEntityWindows();
            if (_SafeStr_3063 != null)
            {
                _SafeStr_3063.initializeImageChain(new Vector.<BitmapData>());
            };
        }

        public function refresh():void
        {
            var _local_1:int;
            var _local_2:int;
            for each (var _local_3:QuestMessageData in _SafeStr_3060)
            {
                _local_1 = (_local_3.sortOrder - 1);
                _local_2 = ((_local_3.completedCampaign) ? 2 : _states[_local_1]);
                if (_local_2 != _states[_local_1])
                {
                    retrieveEntityImageAsset(_local_3.sortOrder, _local_2);
                    updateEntityIndicatorPanel(_local_1, false);
                    if (((_local_2 == 2) && (_SafeStr_3074 == _local_1)))
                    {
                        stopFlashing();
                    };
                };
            };
            initializeBackgroundRendererIfAllImagesInCache();
            initializeEntitiesIfAllImagesInCache();
        }

        public function goToDay(_arg_1:int):void
        {
            scrollToIndex(Math.max(0, Math.min((_arg_1 - 3), maxScrollRightIndex)));
        }

        private function prepareImages():void
        {
            var _local_6:int;
            var _local_4:int;
            var _local_7:int;
            var _local_2:Boolean;
            var _local_3:int;
            var _local_5:int;
            var _local_1:int = int((Math.ceil((_SafeStr_3070 / 7)) + 1));
            _bgAssetNameArray = new Array(_local_1);
            _backgroundImageCache = new Vector.<BitmapData>(_local_1);
            _graphicEntityCache = new Vector.<BitmapData>(_SafeStr_3070);
            _states = new Array(_SafeStr_3070);
            var _local_8:Vector.<BitmapData> = new Vector.<BitmapData>();
            _local_6 = 0;
            while (_local_6 < _local_1)
            {
                _local_8.push(new BitmapData(640, 320, false, 0xFFFFFF));
                _local_6++;
            };
            _SafeStr_3063.initializeImageChain(_local_8);
            _local_4 = firstBgIndex;
            while (_local_4 <= lastBgIndex)
            {
                retrieveBackgroundImageAsset(_local_4);
                _local_4++;
            };
            _SafeStr_3061 = new Map();
            for each (var _local_9:QuestMessageData in _SafeStr_3060)
            {
                if (_local_9.sortOrder <= _SafeStr_3071)
                {
                    _local_7 = ((_local_9.completedCampaign) ? 2 : 0);
                    _local_2 = (((_local_9.sortOrder - 1) >= firstVisibleIndex) && ((_local_9.sortOrder - 1) <= lastVisibleIndex));
                    retrieveEntityImageAsset(_local_9.sortOrder, _local_7, (!(_local_2)));
                };
            };
            if (_SafeStr_3060.length < _SafeStr_3070)
            {
                _local_3 = (_highestAvailableQuestIndex + 1);
                while (_local_3 < _SafeStr_3070)
                {
                    retrieveEntityImageAsset((_local_3 + 1), 1, (_local_3 > lastVisibleIndex));
                    _local_3++;
                };
            };
            _local_5 = 0;
            while (_local_5 < _SafeStr_3070)
            {
                if (_states[_local_5] == null)
                {
                    retrieveEntityImageAsset((_local_5 + 1), 3, ((_local_5 < firstVisibleIndex) || (_local_5 > lastVisibleIndex)));
                };
                _local_5++;
            };
        }

        private function initializeBackgroundRendererIfAllImagesInCache():void
        {
            var _local_2:int;
            var _local_1:BitmapData;
            if (!areViewableBackgroundBitmapsInitialized())
            {
                return;
            };
            var _local_4:Array = [];
            var _local_5:Vector.<BitmapData> = new Vector.<BitmapData>();
            _local_2 = 0;
            while (_local_2 < _backgroundImageCache.length)
            {
                _local_1 = _backgroundImageCache[_local_2];
                if (_local_1 != null)
                {
                    _local_5.push(_local_1);
                }
                else
                {
                    _local_5.push(new BitmapData(640, 320, false, 0xFFFFFF));
                    _local_4.push(_local_2);
                };
                _local_2++;
            };
            _SafeStr_3063.initializeImageChain(_local_5);
            assignCurrentBackgroundSlice();
            for each (var _local_3:int in _local_4)
            {
                retrieveBackgroundImageAsset(_local_3);
            };
        }

        private function cleanUpEntityWindows():void
        {
            if (_entityWindows == null)
            {
                return;
            };
            for each (var _local_1:IWindow in _entityWindows)
            {
                _SafeStr_3066.removeChild(_local_1);
                _local_1.dispose();
            };
            _entityWindows = null;
        }

        private function initializeEntitiesIfAllImagesInCache():void
        {
            var _local_8:IWindowContainer;
            var _local_6:int;
            var _local_9:IBitmapWrapperWindow;
            var _local_2:IWindow;
            var _local_1:IWindow;
            var _local_3:IWindow;
            if (!areViewableEntityBitmapsInitialized())
            {
                return;
            };
            cleanUpEntityWindows();
            if (_entityWindows == null)
            {
                _entityWindows = new Vector.<IWindowContainer>();
            };
            var _local_5:Array = [];
            for each (var _local_4:BitmapData in _graphicEntityCache)
            {
                _local_8 = IWindowContainer(_SafeStr_3067.clone());
                _local_6 = _entityWindows.length;
                if (_local_4 != null)
                {
                    _local_9 = (_local_8.findChildByName("entity_bitmap") as IBitmapWrapperWindow);
                    _local_9.width = _local_4.width;
                    _local_9.height = _local_4.height;
                    _local_9.bitmap = _local_4.clone();
                }
                else
                {
                    _local_5.push(_local_6);
                };
                _local_2 = _local_8.findChildByName("entity_mouse_region");
                _local_2.procedure = entityMouseRegionWindowProcedure;
                if ((((_states[_local_6] == 1) || (_states[_local_6] == 2)) || (_states[_local_6] == 3)))
                {
                    _local_2.visible = false;
                };
                _local_8.visible = true;
                _SafeStr_3066.addChild(_local_8);
                _entityWindows.push(_local_8);
                updateEntityIndicatorPanel(_local_6, false);
            };
            repositionEntityWrappers();
            updateEntityVisibilities();
            _local_1 = _SafeStr_3066.findChildByName("stripe_mask_left");
            _SafeStr_3066.setChildIndex(_local_1, (_SafeStr_3066.numChildren - 1));
            _local_1 = _SafeStr_3066.findChildByName("stripe_mask_right");
            _SafeStr_3066.setChildIndex(_local_1, (_SafeStr_3066.numChildren - 1));
            _local_3 = _SafeStr_3066.findChildByName("button_left");
            _SafeStr_3066.setChildIndex(_local_3, (_SafeStr_3066.numChildren - 1));
            _local_3 = _SafeStr_3066.findChildByName("button_right");
            _SafeStr_3066.setChildIndex(_local_3, (_SafeStr_3066.numChildren - 1));
            for each (var _local_7:int in _local_5)
            {
                retrieveEntityImageAsset((_local_7 + 1), _states[_local_7]);
            };
            if (_states[(_SafeStr_2554.currentDay - 1)] == 0)
            {
                startFlashingAtIndex((_SafeStr_2554.currentDay - 1));
            };
        }

        private function get firstVisibleIndex():int
        {
            var _local_1:int = (_SafeStr_3069 - 1);
            return ((_local_1 < 0) ? 0 : _local_1);
        }

        private function get lastVisibleIndex():int
        {
            var _local_2:int = ((_SafeStr_3069 + 7) + 1);
            var _local_1:int = (_SafeStr_3070 - 1);
            return ((_local_2 > _local_1) ? _local_1 : _local_2);
        }

        private function areViewableEntityBitmapsInitialized():Boolean
        {
            var _local_1:int;
            if (_graphicEntityCache == null)
            {
                return (false);
            };
            _local_1 = firstVisibleIndex;
            while (_local_1 <= lastVisibleIndex)
            {
                if (_graphicEntityCache[_local_1] == null)
                {
                    return (false);
                };
                _local_1++;
            };
            return (true);
        }

        private function get firstBgIndex():int
        {
            var _local_2:int = getBackgroundSliceOffset(_SafeStr_3069);
            var _local_1:int = _SafeStr_3063.getImageIndexForOffset(_local_2);
            return ((_local_1 < 0) ? 0 : _local_1);
        }

        private function get lastBgIndex():int
        {
            var _local_1:int = getBackgroundSliceOffset(_SafeStr_3069);
            return (_SafeStr_3063.getImageIndexForOffset((_local_1 + 640)));
        }

        private function areViewableBackgroundBitmapsInitialized():Boolean
        {
            var _local_1:int;
            if (_backgroundImageCache == null)
            {
                return (false);
            };
            var _local_2:int = getBackgroundSliceOffset(_SafeStr_3069);
            _local_1 = firstBgIndex;
            while (_local_1 <= lastBgIndex)
            {
                if (_backgroundImageCache[_local_1] == null)
                {
                    return (false);
                };
                _local_1++;
            };
            return (true);
        }

        private function updateEntityIndicatorPanel(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_6:BitmapData;
            var _local_7:String;
            if (((_entityWindows == null) || (_entityWindows.length < (_arg_1 - 1))))
            {
                return;
            };
            var _local_3:_SafeStr_124 = _SafeStr_124(_entityWindows[_arg_1].findChildByName("entity_indicator"));
            var _local_5:uint = CalendarEntityStateEnums.INDICATOR_COLOR[_states[_arg_1]];
            if (_arg_2)
            {
                _local_5 = (_local_5 + 0x202020);
            };
            if (_SafeStr_3074 != _arg_1)
            {
                _local_3.color = _local_5;
            };
            var _local_9:IBitmapWrapperWindow = IBitmapWrapperWindow(_entityWindows[_arg_1].findChildByName("entity_indicator_status"));
            if (_states[_arg_1] == 2)
            {
                _local_6 = BitmapData(_questEngine.assets.getAssetByName("calendar_quest_complete").content);
                _local_9.width = _local_6.width;
                _local_9.height = _local_6.height;
                _local_9.bitmap = _local_6.clone();
            }
            else
            {
                _local_9.bitmap = null;
            };
            var _local_4:ITextWindow = (_local_3.findChildByName("entity_indicator_text") as ITextWindow);
            var _local_8:QuestMessageData = getQuestByEntityWindowIndex(_arg_1);
            if (_local_8 != null)
            {
                _local_4.text = _questEngine.getCampaignName(_local_8);
            }
            else
            {
                _local_7 = QuestMessageData.getCampaignLocalizationKeyForCode(((_questEngine.getSeasonalCampaignCodePrefix() + "_") + (_arg_1 + 1)));
                _local_4.text = _questEngine.getCampaignNameByCode(_local_7);
            };
        }

        private function retrieveEntityImageAsset(_arg_1:int, _arg_2:int, _arg_3:Boolean=false):void
        {
            var _local_4:String = ("day" + _arg_1);
            switch (_arg_2)
            {
                case 0:
                case 1:
                case 3:
                    _local_4 = (_local_4 + "_uncomplete");
                    break;
                case 2:
                    _local_4 = (_local_4 + "_completed");
                default:
            };
            _states[(_arg_1 - 1)] = _arg_2;
            _SafeStr_3061[_local_4] = (_arg_1 - 1);
            var _local_5:IAsset = _questEngine.assets.getAssetByName(_local_4);
            if (_local_5 != null)
            {
                assignEntityBitmapToCacheByAssetName(_local_4);
                initializeEntitiesIfAllImagesInCache();
            }
            else
            {
                if (!_arg_3)
                {
                    loadAssetFromImageGallery(_local_4, onEntityImageAssetDownloaded);
                };
            };
        }

        private function retrieveBackgroundImageAsset(_arg_1:int):void
        {
            var _local_2:String = ("background_" + (_arg_1 + 1));
            _bgAssetNameArray[_arg_1] = _local_2;
            var _local_3:IAsset = _questEngine.assets.getAssetByName(_local_2);
            if (_local_3 != null)
            {
                assignBackgroundBitmapToCacheByAssetName(_local_2);
                initializeBackgroundRendererIfAllImagesInCache();
            }
            else
            {
                loadAssetFromImageGallery(_local_2, onBackgroundImageAssetDownloaded);
            };
        }

        private function loadAssetFromImageGallery(_arg_1:String, _arg_2:Function):void
        {
            var _local_5:String = ((getImageGalleryHost() + _arg_1) + ".png");
            var _local_3:URLRequest = new URLRequest(_local_5);
            var _local_4:AssetLoaderStruct = _questEngine.assets.loadAssetFromFile(_arg_1, _local_3, "image/png");
            if (((_local_4) && (!(_local_4.disposed))))
            {
                _local_4.addEventListener("AssetLoaderEventComplete", _arg_2);
                _local_4.addEventListener("AssetLoaderEventError", _arg_2);
            };
        }

        private function onBackgroundImageAssetDownloaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null)
            {
                assignBackgroundBitmapToCacheByAssetName(_local_2.assetName);
            };
            initializeBackgroundRendererIfAllImagesInCache();
        }

        private function onEntityImageAssetDownloaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null)
            {
                assignEntityBitmapToCacheByAssetName(_local_2.assetName);
            };
            initializeEntitiesIfAllImagesInCache();
        }

        private function assignBackgroundBitmapToCacheByAssetName(_arg_1:String):void
        {
            var _local_2:int = _bgAssetNameArray.indexOf(_arg_1);
            if (_local_2 == -1)
            {
                return;
            };
            var _local_3:IAsset = _questEngine.assets.getAssetByName(_arg_1);
            _backgroundImageCache[_local_2] = ((_local_3 != null) ? (_local_3.content as BitmapData) : new BitmapData(640, 320));
        }

        private function assignEntityBitmapToCacheByAssetName(_arg_1:String):void
        {
            var _local_3:IAsset = _questEngine.assets.getAssetByName(_arg_1);
            var _local_2:int = _SafeStr_3061[_arg_1];
            if (((_local_2 == -1) || (_local_2 >= _graphicEntityCache.length)))
            {
                return;
            };
            _graphicEntityCache[_local_2] = ((_local_3 != null) ? (_local_3.content as BitmapData) : new BitmapData(1, 1, true, 0));
        }

        private function repositionEntityWrappers():void
        {
            var _local_1:int;
            if (_entityWindows == null)
            {
                return;
            };
            _local_1 = 0;
            while (_local_1 < _entityWindows.length)
            {
                _entityWindows[_local_1].x = ((((_local_1 - _SafeStr_3069) * 80) + _scrollOffset) + 37);
                _local_1++;
            };
        }

        private function getBackgroundSliceOffset(_arg_1:int):int
        {
            return (_arg_1 * 80);
        }

        private function assignCurrentBackgroundSlice():void
        {
            var _local_1:BitmapData = _SafeStr_3063.getSlice(getBackgroundSliceOffset(_SafeStr_3069), _SafeStr_3066.width);
            _SafeStr_3068.x = 0;
            _SafeStr_3068.width = _local_1.width;
            _SafeStr_3068.height = _local_1.height;
            _SafeStr_3068.bitmap = _local_1.clone();
        }

        private function assignScrollableBackgroundSlice(_arg_1:int):void
        {
            var _local_3:BitmapData;
            var _local_5:int;
            var _local_4:int;
            var _local_2:int;
            var _local_6:int;
            if (_arg_1 < _SafeStr_3069)
            {
                _local_5 = (_SafeStr_3069 - _arg_1);
                _local_4 = getBackgroundSliceOffset(_arg_1);
                _local_3 = _SafeStr_3063.getSlice(_local_4, (_SafeStr_3066.width + (80 * _local_5)));
                _scrollBgStartOffset = -(80 * _local_5);
            }
            else
            {
                _local_2 = (_arg_1 - _SafeStr_3069);
                _local_6 = ((80 * _local_2) + _SafeStr_3066.width);
                _local_3 = _SafeStr_3063.getSlice(getBackgroundSliceOffset(_SafeStr_3069), _local_6);
                _scrollBgStartOffset = 0;
            };
            _SafeStr_3068.x = _scrollBgStartOffset;
            if (_local_3 != null)
            {
                _SafeStr_3068.width = _local_3.width;
                _SafeStr_3068.height = _local_3.height;
                _SafeStr_3068.bitmap = _local_3.clone();
            };
        }

        private function repositionBackgroundSlice():void
        {
            _SafeStr_3068.x = (_scrollBgStartOffset + _scrollOffset);
        }

        private function scrollToIndex(_arg_1:int):void
        {
            if (((_arg_1 < 0) || (_arg_1 >= _SafeStr_3070)))
            {
                return;
            };
            if (((!(_SafeStr_3072 == null)) && (_SafeStr_3072.running)))
            {
                return;
            };
            if (!areViewableEntityBitmapsInitialized())
            {
                _SafeStr_3069 = _arg_1;
                enableScrollArrowsByViewIndex();
                return;
            };
            var _local_2:int = _SafeStr_3069;
            _SafeStr_3069 = _arg_1;
            if (areViewableBackgroundBitmapsInitialized())
            {
                _SafeStr_3069 = _local_2;
                assignScrollableBackgroundSlice(_arg_1);
                updateEntityVisibilities(true, (_arg_1 - _SafeStr_3069));
                _SafeStr_3073 = (-(80 * (_arg_1 - _SafeStr_3069)) / 10);
                _SafeStr_3072 = new Timer(10, 10);
                _SafeStr_3072.addEventListener("timer", onAnimateScroll);
                _SafeStr_3072.addEventListener("timerComplete", onAnimateScroll);
                _SafeStr_3072.start();
            }
            else
            {
                _SafeStr_3069 = _local_2;
            };
        }

        private function get maxScrollRightIndex():int
        {
            return (_SafeStr_3071 - 7);
        }

        private function enableScrollArrowsByViewIndex():void
        {
            if (_SafeStr_3069 > 0)
            {
                _SafeStr_3064.activate();
            }
            else
            {
                _SafeStr_3064.deactivate();
            };
            if (_SafeStr_3069 < Math.min(((_SafeStr_3070 - 3) - 1), maxScrollRightIndex))
            {
                _SafeStr_3065.activate();
            }
            else
            {
                _SafeStr_3065.deactivate();
            };
        }

        private function updateEntityVisibilities(_arg_1:Boolean=false, _arg_2:int=0):void
        {
            var _local_4:int;
            var _local_3:int;
            var _local_5:int;
            if (_entityWindows != null)
            {
                _local_4 = (_SafeStr_3069 - 1);
                if (((_arg_1) && (_arg_2 < 0)))
                {
                    _local_4 = (_local_4 + _arg_2);
                };
                _local_3 = ((_SafeStr_3069 + 7) + 1);
                if (((_arg_1) && (_arg_2 > 0)))
                {
                    _local_3 = (_local_3 + _arg_2);
                };
                _local_5 = 0;
                while (_local_5 < _entityWindows.length)
                {
                    if (((_local_5 < _local_4) || (_local_5 > _local_3)))
                    {
                        _entityWindows[_local_5].visible = false;
                    }
                    else
                    {
                        _entityWindows[_local_5].visible = true;
                        if (((_local_5 == _local_4) || (_local_5 == _local_3)))
                        {
                            _entityWindows[_local_5].getChildByName("entity_mouse_region").visible = false;
                        }
                        else
                        {
                            if (_states[_local_5] == 0)
                            {
                                _entityWindows[_local_5].getChildByName("entity_mouse_region").visible = true;
                            };
                        };
                    };
                    _local_5++;
                };
            };
        }

        private function onAnimateScroll(_arg_1:TimerEvent):void
        {
            switch (_arg_1.type)
            {
                case "timer":
                    _scrollOffset = (_scrollOffset + _SafeStr_3073);
                    repositionBackgroundSlice();
                    repositionEntityWrappers();
                    return;
                case "timerComplete":
                    _scrollOffset = 0;
                    if (_SafeStr_3073 > 0)
                    {
                        _SafeStr_3069 = (_SafeStr_3069 - 1);
                    }
                    else
                    {
                        _SafeStr_3069 = (_SafeStr_3069 + 1);
                    };
                    assignCurrentBackgroundSlice();
                    repositionEntityWrappers();
                    enableScrollArrowsByViewIndex();
                    updateEntityVisibilities();
                    _SafeStr_3072.removeEventListener("timer", onAnimateScroll);
                    _SafeStr_3072.removeEventListener("timerComplete", onAnimateScroll);
                    return;
            };
        }

        private function scrollArrowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_DOWN")
            {
                switch (_arg_2.name)
                {
                    case "button_left":
                        _SafeStr_3077 = true;
                        break;
                    case "button_right":
                        _SafeStr_3078 = true;
                };
            };
            if (((_arg_1.type == "WME_UP") || (_arg_1.type == "WME_UP_OUTSIDE")))
            {
                _SafeStr_3077 = false;
                _SafeStr_3078 = false;
            };
        }

        private function entityMouseRegionWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            var _local_4:QuestMessageData;
            if (_arg_2.name == "entity_mouse_region")
            {
                _local_3 = _entityWindows.indexOf((_arg_2.parent as IWindowContainer));
                if (_arg_1.type == "WME_CLICK")
                {
                    _local_4 = getQuestByEntityWindowIndex(_local_3);
                    if (_local_4 != null)
                    {
                        _questEngine.questController.questDetails.openDetails(_local_4, true);
                    };
                };
                if (_arg_1.type == "WME_OVER")
                {
                    updateEntityIndicatorPanel(_local_3, true);
                    _SafeStr_3076 = _local_3;
                };
                if (_arg_1.type == "WME_OUT")
                {
                    updateEntityIndicatorPanel(_local_3, false);
                    _SafeStr_3076 = -1;
                };
            };
        }

        private function getQuestByEntityWindowIndex(_arg_1:int):QuestMessageData
        {
            for each (var _local_2:QuestMessageData in _SafeStr_3060)
            {
                if ((_local_2.sortOrder - 1) == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function update(_arg_1:uint):void
        {
            var _local_5:int;
            var _local_4:Number;
            var _local_2:_SafeStr_124;
            var _local_3:Number;
            if (((!(_entityWindows == null)) && (!(_SafeStr_3074 == -1))))
            {
                _local_5 = CalendarEntityStateEnums.INDICATOR_COLOR[_states[_SafeStr_3074]];
                _local_4 = ((_SafeStr_3075 % 2000) / 2000);
                _local_4 = Math.abs((2 * ((_local_4 > 0.5) ? _local_4 = (_local_4 - 1) : _local_4)));
                _local_2 = _SafeStr_124(_entityWindows[_SafeStr_3074].findChildByName("entity_indicator"));
                if (_local_2)
                {
                    _local_3 = (_local_4 * 100);
                    if (_SafeStr_3076 == _SafeStr_3074)
                    {
                        _local_3 = (_local_3 + 20);
                    };
                    _local_2.color = adjustBrightness(_local_5, _local_3);
                };
                _SafeStr_3075 = (_SafeStr_3075 + _arg_1);
            };
            if (_SafeStr_3072 != null)
            {
                if ((((_SafeStr_3077) && (!(_SafeStr_3072.running))) && (_scrollOffset == 0)))
                {
                    if (((_SafeStr_3069 > 0) && (!(_SafeStr_3064.isInactive()))))
                    {
                        scrollToIndex((_SafeStr_3069 - 1));
                    };
                };
                if ((((_SafeStr_3078) && (!(_SafeStr_3072.running))) && (_scrollOffset == 0)))
                {
                    if (((_SafeStr_3069 < _highestAvailableQuestIndex) && (!(_SafeStr_3065.isInactive()))))
                    {
                        scrollToIndex((_SafeStr_3069 + 1));
                    };
                };
            };
        }

        private function startFlashingAtIndex(_arg_1:int):void
        {
            if (((_arg_1 < 0) || (_arg_1 >= _SafeStr_3070)))
            {
                return;
            };
            _SafeStr_3074 = _arg_1;
            _SafeStr_3075 = 0;
        }

        private function stopFlashing():void
        {
            _SafeStr_3074 = -1;
        }

        private function onDateRefreshTimer(_arg_1:TimerEvent):void
        {
            var _local_2:Date = new Date();
            if (_SafeStr_3080 != _local_2.getDate())
            {
                _questEngine.requestSeasonalQuests();
            };
            _SafeStr_3080 = _local_2.getDate();
        }


    }
}