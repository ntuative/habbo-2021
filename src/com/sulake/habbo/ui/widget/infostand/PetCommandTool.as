package com.sulake.habbo.ui.widget.infostand
{
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.window.events.WindowEvent;

    public class PetCommandTool 
    {

        private static const DEFAULT_LOCATION:Point = new Point(100, 70);
        private static const STATUS_BAR_WIDTH:int = 162;
        private static const STATUS_BAR_HEIGHT:int = 16;
        private static const STATUS_BAR_HIGHLIGHT_HEIGHT:int = 4;
        private static const STATUS_BAR_BORDER_COLOR:uint = 0xDADADA;
        private static const STATUS_BAR_BG_COLOR:uint = 0x3A3A3A;
        private static const STATUS_BAR_SKILL_HIGHLIGHT_COLOR:uint = 10513106;
        private static const STATUS_BAR_SKILL_CONTENT_COLOR:uint = 8734654;
        private static const STATE_SKILL:String = "skill";
        private static const PET_TYPE_HORSE:int = 15;

        private const BUTTONS_DISABLED_MS:int = 1100;

        private var _SafeStr_1324:InfoStandWidget;
        private var _SafeStr_4172:IFrameWindow;
        private var _SafeStr_4173:IWindow;
        private var _SafeStr_4144:Map;
        private var _SafeStr_4156:int;
        private var _currentPetName:String;
        private var _SafeStr_4171:Timer;

        public function PetCommandTool(_arg_1:InfoStandWidget)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_4144 = new Map();
            _SafeStr_4171 = new Timer(1100);
            _SafeStr_4171.addEventListener("timer", onButtonDisableTimeout);
        }

        public static function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }

        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_2:int;
            var _local_4:IWindow;
            var _local_3:int;
            _local_2 = 0;
            while (_local_2 < _arg_1.numChildren)
            {
                _local_4 = _arg_1.getChildAt(_local_2);
                if (_local_4.visible)
                {
                    _local_3 = Math.max(_local_3, (_local_4.y + _local_4.height));
                };
                _local_2++;
            };
            return (_local_3);
        }

        private static function createPercentageBar(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:uint):BitmapData
        {
            _arg_2 = Math.max(_arg_2, 1);
            _arg_1 = Math.max(_arg_1, 0);
            if (_arg_1 > _arg_2)
            {
                _arg_1 = _arg_2;
            };
            var _local_10:Number = (_arg_1 / _arg_2);
            var _local_9:int = 1;
            var _local_7:BitmapData = new BitmapData(162, 16, false);
            _local_7.fillRect(new Rectangle(0, 0, _local_7.width, _local_7.height), 0xDADADA);
            var _local_8:Rectangle = new Rectangle(_local_9, _local_9, (_local_7.width - (_local_9 * 2)), (_local_7.height - (_local_9 * 2)));
            _local_7.fillRect(_local_8, 0x3A3A3A);
            var _local_6:Rectangle = new Rectangle(_local_9, (_local_9 + 4), (_local_7.width - (_local_9 * 2)), ((_local_7.height - (_local_9 * 2)) - 4));
            _local_6.width = (_local_10 * _local_6.width);
            _local_7.fillRect(_local_6, _arg_3);
            var _local_5:Rectangle = new Rectangle(_local_9, _local_9, (_local_7.width - (_local_9 * 2)), 4);
            _local_5.width = (_local_10 * _local_5.width);
            _local_7.fillRect(_local_5, _arg_4);
            return (_local_7);
        }


        public function dispose():void
        {
            if (_SafeStr_4171)
            {
                _SafeStr_4171.stop();
                _SafeStr_4171 = null;
            };
            if (_SafeStr_1324)
            {
                _SafeStr_1324 = null;
            };
            if (_SafeStr_4172)
            {
                _SafeStr_4172.dispose();
            };
            _SafeStr_4172 = null;
        }

        public function getPetId():int
        {
            return (_SafeStr_4156);
        }

        public function isVisible():Boolean
        {
            if (_SafeStr_4172 == null)
            {
                return (false);
            };
            return (_SafeStr_4172.visible);
        }

        public function showCommandToolForPet(_arg_1:int, _arg_2:String, _arg_3:BitmapData, _arg_4:int, _arg_5:int, _arg_6:Number, _arg_7:int, _arg_8:Array):void
        {
            if (_SafeStr_4172 == null)
            {
                return;
            };
            updateStateElement("skill", ((_arg_5 + _arg_6) * 100), (_arg_7 * 100), 8734654, 10513106, _arg_4);
            if (_SafeStr_4156 == _arg_1)
            {
                return;
            };
            _SafeStr_4156 = _arg_1;
            _currentPetName = _arg_2;
            var _local_10:ITextWindow = (_SafeStr_4172.findChildByName("pet_name") as ITextWindow);
            if (_local_10 != null)
            {
                _local_10.text = _arg_2;
            };
            updatePetImage(_arg_3);
            var _local_9:CommandConfiguration = (_SafeStr_4144.getValue(_arg_1) as CommandConfiguration);
            if (_local_9 == null)
            {
                disableAllButtons();
                requestEnabledCommands(_SafeStr_4156);
            }
            else
            {
                updateCommandButtonsViewState(_local_9);
            };
        }

        public function updatePetImage(_arg_1:BitmapData):void
        {
            var _local_2:BitmapData;
            var _local_4:Point;
            var _local_3:IBitmapWrapperWindow = (_SafeStr_4172.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_local_3 != null)
            {
                if (_arg_1 != null)
                {
                    _local_2 = new BitmapData(_local_3.width, _local_3.height, true, 0);
                    _local_4 = new Point(0, 0);
                    _local_4.x = Math.round(((_local_3.width - _arg_1.width) / 2));
                    _local_4.y = Math.round(((_local_3.height - _arg_1.height) / 2));
                    _local_2.copyPixels(_arg_1, _arg_1.rect, _local_4);
                    _local_3.bitmap = _local_2;
                }
                else
                {
                    _local_3.bitmap = null;
                };
                _local_3.invalidate();
            };
        }

        private function onButtonDisableTimeout(_arg_1:TimerEvent):void
        {
            var _local_2:CommandConfiguration = (_SafeStr_4144.getValue(_SafeStr_4156) as CommandConfiguration);
            updateCommandButtonsViewState(_local_2);
            _SafeStr_4171.stop();
        }

        public function setEnabledCommands(_arg_1:int, _arg_2:CommandConfiguration):void
        {
            _SafeStr_4144.remove(_arg_1);
            _SafeStr_4144.add(_arg_1, _arg_2);
            if (_arg_1 != _SafeStr_4156)
            {
                return;
            };
            updateCommandButtonsViewState(_arg_2);
            _SafeStr_4171.stop();
        }

        public function showWindow(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (_SafeStr_4172 == null)
                {
                    createCommandWindow();
                };
                _SafeStr_4172.visible = true;
            }
            else
            {
                if (_SafeStr_4172 != null)
                {
                    _SafeStr_4172.visible = false;
                };
            };
            _SafeStr_4171.stop();
        }

        private function requestEnabledCommands(_arg_1:int):void
        {
            var _local_2:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage("RWPCM_REQUEST_PET_COMMANDS", _arg_1);
            _SafeStr_1324.messageListener.processWidgetMessage(_local_2);
        }

        private function createCommandWindow():void
        {
            var _local_7:BitmapDataAsset;
            var _local_4:BitmapData;
            var _local_3:XmlAsset = (_SafeStr_1324.assets.getAssetByName("pet_commands") as XmlAsset);
            _SafeStr_4172 = (_SafeStr_1324.windowManager.buildFromXML((_local_3.content as XML)) as IFrameWindow);
            if (_SafeStr_4172 == null)
            {
                throw (new Error("Failed to construct command window from XML!"));
            };
            _SafeStr_4172.context.getDesktopWindow().addEventListener("WE_RESIZED", onWindowDesktopResized);
            _SafeStr_4173 = IWindowContainer(_SafeStr_4172.findChildByName("commands_container")).removeChildAt(0);
            var _local_1:IWindow = _SafeStr_4172.findChildByName("header_button_close");
            if (_local_1 != null)
            {
                _local_1.addEventListener("WME_CLICK", onCommandWindowClose);
            };
            var _local_5:IWindow = _SafeStr_4172.findChildByName("description_link");
            if (_local_5 != null)
            {
                _local_5.addEventListener("WME_CLICK", onCommandWindowDescriptionLink);
            };
            var _local_2:IWindow = _SafeStr_4172.findChildByName("avatar_image");
            if (_local_2 != null)
            {
                _local_2.addEventListener("WME_CLICK", onCommandWindowAvatarImageClick);
            };
            var _local_6:IBitmapWrapperWindow = (_SafeStr_4172.findChildByName("status_skill_icon") as IBitmapWrapperWindow);
            if (_local_6 != null)
            {
                _local_7 = (_SafeStr_1324.assets.getAssetByName("icon_pet_skill") as BitmapDataAsset);
                _local_4 = (_local_7.content as BitmapData);
                _local_6.bitmap = _local_4.clone();
            };
            _SafeStr_4172.position = DEFAULT_LOCATION;
        }

        private function updateCommandButtonsViewState(_arg_1:CommandConfiguration):void
        {
            var _local_7:int;
            var _local_3:_SafeStr_101;
            var _local_10:int;
            if (_SafeStr_4172 == null)
            {
                return;
            };
            var _local_6:IWindowContainer = IWindowContainer(_SafeStr_4172.findChildByName("commands_container"));
            hideChildren(_local_6);
            var _local_8:Array = _arg_1.allCommandIds;
            var _local_12:int = 25;
            var _local_11:int;
            var _local_2:int = 86;
            var _local_9:int;
            _local_7 = 0;
            while (_local_7 < _local_8.length)
            {
                _local_3 = (_local_6.getChildAt(_local_7) as _SafeStr_101);
                if (_local_3 == null)
                {
                    _local_3 = (_SafeStr_4173.clone() as _SafeStr_101);
                    _local_3.addEventListener("WME_CLICK", onTrainButtonMouseClick);
                    _local_6.addChild(_local_3);
                };
                _local_3.visible = true;
                _local_10 = _local_8[_local_7];
                _local_3.id = _local_10;
                _local_3.caption = _SafeStr_1324.localizations.getLocalization(("pet.command." + _local_10));
                if (_arg_1.isEnabled(_local_10))
                {
                    _local_3.enable();
                }
                else
                {
                    _local_3.disable();
                };
                _local_3.y = _local_9;
                if ((_local_7 % 2) == 1)
                {
                    _local_9 = (_local_9 + _local_12);
                    _local_3.x = _local_2;
                }
                else
                {
                    _local_3.x = _local_11;
                };
                _local_7++;
            };
            var _local_4:Boolean = _SafeStr_1324.config.getBoolean("pet.enhancements.enabled");
            var _local_5:int = ((_local_4) ? 180 : 160);
            _local_6.height = getLowestPoint(_local_6);
            _SafeStr_4172.height = (_local_6.height + _local_5);
            _SafeStr_4171.stop();
        }

        private function disableAllButtons():void
        {
            var _local_3:int;
            var _local_1:_SafeStr_101;
            if (_SafeStr_4172 == null)
            {
                return;
            };
            var _local_2:IWindowContainer = IWindowContainer(_SafeStr_4172.findChildByName("commands_container"));
            _local_3 = 0;
            while (_local_3 < _local_2.numChildren)
            {
                _local_1 = _SafeStr_101(_local_2.getChildAt(_local_3));
                _local_1.disable();
                _local_3++;
            };
        }

        private function onCommandWindowClose(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_4172.visible = false;
        }

        private function onCommandWindowDescriptionLink(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.windowManager.openHelpPage("help/pets/training");
        }

        private function onCommandWindowAvatarImageClick(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_REQUEST_PET_UPDATE", _SafeStr_4156));
        }

        private function onTrainButtonMouseClick(_arg_1:WindowMouseEvent):void
        {
            var _local_6:IWindow = _arg_1.target;
            var _local_5:int = _local_6.id;
            var _local_3:String = ("pet.command." + _local_5);
            var _local_2:String = _SafeStr_1324.localizations.getLocalization(_local_3);
            var _local_4:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage("RWPCM_PET_COMMAND", _SafeStr_4156, ((_currentPetName + " ") + _local_2));
            _SafeStr_1324.messageListener.processWidgetMessage(_local_4);
            disableAllButtons();
            _SafeStr_4171.start();
        }

        private function onWindowDesktopResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow;
            var _local_3:Rectangle;
            if (((_SafeStr_4172) && (!(_SafeStr_4172.disposed))))
            {
                _local_2 = _arg_1.window;
                _local_3 = new Rectangle();
                _SafeStr_4172.getGlobalRectangle(_local_3);
                if (_local_3.x > _local_2.width)
                {
                    _SafeStr_4172.x = (_local_2.width - _SafeStr_4172.width);
                    _SafeStr_4172.getGlobalRectangle(_local_3);
                };
                if ((_local_3.x + _local_3.width) <= 0)
                {
                    _SafeStr_4172.x = 0;
                    _SafeStr_4172.getGlobalRectangle(_local_3);
                };
                if (_local_3.y > _local_2.height)
                {
                    _SafeStr_4172.y = 0;
                    _SafeStr_4172.getGlobalRectangle(_local_3);
                };
                if ((_local_3.y + _local_3.height) <= 0)
                {
                    _SafeStr_4172.y = 0;
                    _SafeStr_4172.getGlobalRectangle(_local_3);
                };
            };
        }

        private function updateStateElement(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:uint, _arg_5:uint, _arg_6:int):void
        {
            var _local_8:BitmapData;
            if (_SafeStr_4172 == null)
            {
                return;
            };
            var _local_7:IWindowContainer = (_SafeStr_4172.findChildByName((("status_" + _arg_1) + "_container")) as IWindowContainer);
            if (_local_7 == null)
            {
                return;
            };
            _local_7.visible = ((_SafeStr_1324.config.getBoolean("pet.enhancements.enabled")) && (_arg_6 == 15));
            var _local_10:ITextWindow = (_local_7.findChildByName((("status_" + _arg_1) + "_value_text")) as ITextWindow);
            if (_local_10 != null)
            {
                _local_10.text = ((_arg_2 + "/") + _arg_3);
            };
            var _local_11:ITextWindow = (_local_7.findChildByName((("status_" + _arg_1) + "_text")) as ITextWindow);
            if (_local_11 != null)
            {
                _local_11.caption = (("${infostand.pet.text.skill.next." + _arg_6) + "}");
            };
            var _local_9:IBitmapWrapperWindow = (_local_7.findChildByName((("status_" + _arg_1) + "_bitmap")) as IBitmapWrapperWindow);
            if (_local_9 != null)
            {
                _local_8 = createPercentageBar(_arg_2, _arg_3, _arg_4, _arg_5);
                if (_local_8 != null)
                {
                    _local_9.bitmap = _local_8;
                    _local_9.width = _local_8.width;
                    _local_9.height = _local_8.height;
                    _local_9.invalidate();
                };
            };
        }


    }
}

