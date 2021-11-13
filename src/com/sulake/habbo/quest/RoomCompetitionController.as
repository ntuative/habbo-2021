package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.competition.CompetitionVotingInfoMessageEvent;
    import com.sulake.habbo.communication.messages.parser.competition.CompetitionEntrySubmitResultMessageEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.competition._SafeStr_49;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.competition.SubmitRoomToCompetitionMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.competition.VoteForRoomMessageComposer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.events.TimerEvent;

    public class RoomCompetitionController implements IDisposable, IGetImageListener 
    {

        private static const INDENT_LEFT:int = 270;
        private static const INDENT_RIGHT:int = 200;
        private static const INDENT_TOP:int = 4;

        private var _window:IWindowContainer;
        private var _questEngine:HabboQuestEngine;
        private var _SafeStr_2343:String;
        private var _SafeStr_3150:int;
        private var _SafeStr_3151:int;
        private var _submit:Boolean;
        private var _dontShowAgain:Boolean;
        private var _hideTimer:Timer = new Timer(3000, 1);
        private var _SafeStr_834:int;
        private var _SafeStr_3152:Map = new Map();

        public function RoomCompetitionController(_arg_1:HabboQuestEngine)
        {
            _questEngine = _arg_1;
            _hideTimer.addEventListener("timer", onHideTimer);
        }

        public function dispose():void
        {
            _questEngine = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
            if (_hideTimer)
            {
                _hideTimer.removeEventListener("timer", onHideTimer);
                _hideTimer.reset();
                _hideTimer = null;
            };
            if (_SafeStr_3152)
            {
                _SafeStr_3152.dispose();
                _SafeStr_3152 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_window == null);
        }

        private function setText(_arg_1:IWindow, _arg_2:String, _arg_3:String):void
        {
            var _local_5:String = ((_arg_2 + ".") + _arg_3);
            var _local_4:String = _questEngine.localization.getLocalization(_local_5, "");
            if (_local_4 == "")
            {
                _local_5 = _arg_2;
                _local_4 = _questEngine.localization.getLocalization(_local_5, "");
            };
            if (_local_4 == "")
            {
                _arg_1.visible = false;
            }
            else
            {
                _arg_1.visible = true;
                _questEngine.localization.registerParameter(_local_5, "competition_name", getCompetitionName());
                _questEngine.localization.registerParameter(_local_5, "votes", ("" + _SafeStr_3151));
                _arg_1.caption = (("${" + _local_5) + "}");
            };
        }

        public function onCompetitionVotingInfo(_arg_1:CompetitionVotingInfoMessageEvent):void
        {
            _SafeStr_3151 = _arg_1.getParser().votesRemaining;
            var _local_2:Boolean = _arg_1.getParser().isVotingAllowedForUser;
            var _local_3:int = _arg_1.getParser().resultCode;
            refreshContent(_arg_1.getParser().goalId, false, _arg_1.getParser().goalCode, _local_3.toString());
            setInfoRegionProc(((_local_3 == 1) ? onTalents : onSeeParticipants));
            getActionButton().procedure = onVote;
            getActionButton().visible = ((_SafeStr_3151 > 0) && (_local_2));
            getButtonInfoText().visible = _local_2;
        }

        public function onCompetitionEntrySubmitResult(_arg_1:CompetitionEntrySubmitResultMessageEvent):void
        {
            if (_arg_1.getParser().result == 5)
            {
                return;
            };
            refreshContent(_arg_1.getParser().goalId, true, _arg_1.getParser().goalCode, ("" + _arg_1.getParser().result));
            _SafeStr_834 = _arg_1.getParser().result;
            if (_SafeStr_834 == 2)
            {
                setInfoRegionProc(null);
                getActionButton().procedure = onConfirm;
            }
            else
            {
                if (_SafeStr_834 == 6)
                {
                    setInfoRegionProc(onGoToHotelView);
                    getActionButton().procedure = onAccept;
                }
                else
                {
                    if (_SafeStr_834 == 1)
                    {
                        setInfoRegionProc(onGoToHotelView);
                        getActionButton().procedure = onSubmit;
                    }
                    else
                    {
                        if (_SafeStr_834 == 3)
                        {
                            setInfoRegionProc(onCatalogLink);
                            getActionButton().visible = false;
                            refreshRequiredFurnis(_arg_1);
                            getRequiredFurnisWindow().visible = true;
                        }
                        else
                        {
                            if (_SafeStr_834 == 0)
                            {
                                setInfoRegionProc(onGoToHotelView);
                                getActionButton().procedure = onClose;
                            }
                            else
                            {
                                if (_SafeStr_834 == 4)
                                {
                                    setInfoRegionProc(null);
                                    getActionButton().procedure = null;
                                    getActionButton().visible = false;
                                }
                                else
                                {
                                    if (_SafeStr_834 == 5)
                                    {
                                        setInfoRegionProc(null);
                                        getActionButton().procedure = onOpenNavigator;
                                        getActionButton().visible = true;
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function setInfoRegionProc(_arg_1:Function):void
        {
            getInfoRegion().procedure = _arg_1;
            getInfoRegion().setParamFlag(1, (!(_arg_1 == null)));
        }

        public function refreshContent(_arg_1:int, _arg_2:Boolean, _arg_3:String, _arg_4:String):void
        {
            _SafeStr_3150 = _arg_1;
            _SafeStr_2343 = _arg_3;
            _submit = _arg_2;
            prepare();
            setTexts(((_arg_2) ? "submit" : "vote"), _arg_4);
            getActionButton().visible = true;
            setPromoImage();
            showAndPositionWindow();
            getRequiredFurnisWindow().visible = false;
            _window.findChildByName("dont_show_again_container").visible = false;
            _window.findChildByName("normal_container").visible = true;
        }

        private function setPromoImage():void
        {
            getVoteImage().visible = (!(_submit));
            getSubmitImage().visible = _submit;
        }

        private function showAndPositionWindow():void
        {
            _window.visible = true;
            var _local_1:Rectangle = _window.desktop.rectangle;
            _window.x = 270;
            _window.y = 4;
            _window.width = ((_local_1.width - 270) - 200);
            _window.activate();
        }

        private function refreshRequiredFurnis(_arg_1:CompetitionEntrySubmitResultMessageEvent):void
        {
            var _local_3:int;
            var _local_5:String;
            var _local_4:Array;
            var _local_7:String;
            var _local_6:String;
            var _local_8:IWindowContainer;
            var _local_2:_SafeStr_147;
            var _local_9:Array = _arg_1.getParser().requiredFurnis;
            _local_3 = 0;
            while (_local_3 < _local_9.length)
            {
                _local_5 = _local_9[_local_3];
                _local_4 = _local_5.split("*");
                _local_7 = _local_4[0];
                _local_6 = ((_local_4.length > 1) ? _local_4[1] : "");
                _local_8 = getRequiredFurniWindow((_local_3 + 1));
                if (_local_5 == null)
                {
                    _local_8.visible = false;
                }
                else
                {
                    _local_8.visible = true;
                    _local_8.findChildByName("tick_icon").visible = (!(_arg_1.getParser().isMissing(_local_5)));
                    _local_2 = _questEngine.roomEngine.getGenericRoomObjectImage(_local_7, _local_6, new Vector3d(180, 0, 0), 1, this);
                    if (_local_2.id != 0)
                    {
                        _SafeStr_3152.add(_local_2.id, _local_3);
                    };
                    setRequiredFurniImage(_local_3, _local_2.data);
                };
                _local_3++;
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (_SafeStr_3152.getValue(_arg_1) != null)
            {
                setRequiredFurniImage(_SafeStr_3152.getValue(_arg_1), _arg_2);
                _SafeStr_3152.remove(_arg_1);
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        private function setRequiredFurniImage(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_4:IWindowContainer = getRequiredFurniWindow((_arg_1 + 1));
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_4.findChildByName("furni_icon"));
            var _local_3:BitmapData = new BitmapData(_local_5.width, _local_5.height, true, 0);
            if (_arg_2 != null)
            {
                _local_3.copyPixels(_arg_2, _arg_2.rect, new Point(((_local_3.width - _arg_2.width) / 2), ((_local_3.height - _arg_2.height) / 2)));
                _local_5.bitmap = _local_3;
            };
        }

        private function getCompetitionName():String
        {
            var _local_1:String = (("roomcompetition." + _SafeStr_2343) + ".name");
            return (_questEngine.localization.getLocalization(_local_1, _local_1));
        }

        private function setTexts(_arg_1:String, _arg_2:String):void
        {
            setText(getCaption(), ("roomcompetition.caption." + _arg_1), _arg_2);
            setText(getInfoText(), ("roomcompetition.info." + _arg_1), _arg_2);
            setText(getActionButton(), ("roomcompetition.button." + _arg_1), _arg_2);
            setText(getButtonInfoText(), ("roomcompetition.buttoninfo." + _arg_1), _arg_2);
            onResize();
        }

        private function onResize():void
        {
            getInfoRegion().y = ((getCaption().y + getCaption().textHeight) + 5);
        }

        public function onRoomExit():void
        {
            close();
        }

        public function onRoomEnter(_arg_1:RoomEntryInfoMessageEvent):void
        {
            close();
            var _local_3:RoomEntryInfoMessageParser = _arg_1.getParser();
            var _local_2:Boolean = ((_questEngine.getInteger("new.identity", 0) == 0) || (!(_questEngine.getBoolean("new.identity.hide.ui"))));
            if (((!(_dontShowAgain)) && (_local_2)))
            {
                _submit = _local_3.owner;
                _questEngine.send(new _SafeStr_49());
            };
        }

        public function sendRoomCompetitionInit():void
        {
            _questEngine.send(new _SafeStr_49());
        }

        public function onContextChanged():void
        {
            if ((((!(_window == null)) && (_window.visible)) && (_submit)))
            {
                _questEngine.send(new SubmitRoomToCompetitionMessageComposer(_SafeStr_2343, 0));
            };
        }

        private function close():void
        {
            if (_window)
            {
                _window.visible = false;
            };
            _SafeStr_2343 = "";
        }

        private function prepare():void
        {
            var _local_1:int;
            if (_window == null)
            {
                _local_1 = 1;
                _window = IWindowContainer(_questEngine.getXmlWindow("RoomCompetition", _local_1));
                _window.findChildByName("close_region").procedure = onClose;
                _questEngine.windowManager.getWindowContext(_local_1).getDesktopWindow().addEventListener("WE_RESIZED", onDesktopResized);
                _window.findChildByName("dont_show_again_region").procedure = onDontShowAgain;
            };
        }

        private function onCatalogLink(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.catalog.openCatalogPage(_questEngine.getProperty((("competition." + _SafeStr_2343) + ".catalogPage")));
            };
        }

        private function onOpenNavigator(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.navigator.open();
            };
        }

        private function onGoToHotelView(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:HabboToolbarEvent;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = new HabboToolbarEvent("HTE_TOOLBAR_CLICK");
                _local_3.iconId = "HTIE_ICON_RECEPTION";
                _questEngine.toolbar.events.dispatchEvent(_local_3);
            };
        }

        private function onSeeParticipants(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
        }

        private function onTalents(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.tracking.trackTalentTrackOpen(_questEngine.sessionDataManager.currentTalentTrack, "roomcompetition");
                _questEngine.send(new GetTalentTrackMessageComposer(_questEngine.sessionDataManager.currentTalentTrack));
            };
        }

        private function onAccept(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.send(new SubmitRoomToCompetitionMessageComposer(_SafeStr_2343, 1));
            };
        }

        private function onSubmit(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.send(new SubmitRoomToCompetitionMessageComposer(_SafeStr_2343, 2));
            };
        }

        private function onConfirm(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.send(new SubmitRoomToCompetitionMessageComposer(_SafeStr_2343, 3));
            };
        }

        private function onVote(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _questEngine.send(new VoteForRoomMessageComposer(_SafeStr_2343));
            };
        }

        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            var _local_3:String;
            if (_arg_1.type == "WME_CLICK")
            {
                if (((_submit) && (_SafeStr_834 == 0)))
                {
                    close();
                    return;
                };
                _local_3 = ("roomcompetition.dontshowagain.info." + ((_submit) ? "submit" : "vote"));
                _window.findChildByName("dont_show_info_txt").caption = _questEngine.localization.getLocalization(_local_3, _local_3);
                _window.findChildByName("dont_show_again_container").visible = true;
                _window.findChildByName("normal_container").visible = false;
                _hideTimer.reset();
                _hideTimer.start();
            };
        }

        private function onDontShowAgain(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                _dontShowAgain = true;
                close();
            };
        }

        private function getInfoRegion():IWindow
        {
            return (_window.findChildByName("info_region"));
        }

        private function getInfoText():IWindow
        {
            return (_window.findChildByName("info_txt"));
        }

        private function getButtonInfoText():IWindow
        {
            return (_window.findChildByName("button_info_txt"));
        }

        private function getActionButton():IWindow
        {
            return (_window.findChildByName("action_button"));
        }

        private function getCaption():ITextWindow
        {
            return (ITextWindow(_window.findChildByName("caption_txt")));
        }

        private function getRequiredFurnisWindow():IWindow
        {
            return (_window.findChildByName("required_furnis_itemgrid"));
        }

        private function getVoteImage():IWindow
        {
            return (_window.findChildByName("vote_image"));
        }

        private function getSubmitImage():IWindow
        {
            return (_window.findChildByName("submit_image"));
        }

        private function getRequiredFurniWindow(_arg_1:int):IWindowContainer
        {
            var _local_3:int;
            var _local_4:IItemGridWindow = IItemGridWindow(_window.findChildByName("required_furnis_itemgrid"));
            var _local_2:IWindowContainer = IWindowContainer(_local_4.getGridItemAt(0));
            if (_local_4.numGridItems < _arg_1)
            {
                _local_3 = 0;
                while (_local_3 < (_arg_1 - _local_4.numGridItems))
                {
                    _local_4.addGridItem(_local_2.clone());
                    _local_3++;
                };
            };
            return (IWindowContainer(_local_4.getGridItemAt((_arg_1 - 1))));
        }

        private function onDesktopResized(_arg_1:WindowEvent):void
        {
            if (((!(_window == null)) && (_window.visible)))
            {
                onResize();
            };
        }

        public function set dontShowAgain(_arg_1:Boolean):void
        {
            _dontShowAgain = _arg_1;
        }

        private function onHideTimer(_arg_1:TimerEvent):void
        {
            close();
        }


    }
}

