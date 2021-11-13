package com.sulake.habbo.inventory.trading
{
    import com.sulake.habbo.inventory.IInventoryModel;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.inventory.HabboInventory;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.room.object.data.StringArrayStuffData;
    import com.sulake.habbo.room.IStuffData;
    import flash.events.Event;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.inventory.items.IFurnitureItem;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import com.sulake.habbo.inventory.items.FurnitureItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradeOpenFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.OpenTradingComposer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemToTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AddItemsToTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.RemoveItemFromTradeComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.AcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.UnacceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmAcceptTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.ConfirmDeclineTradingComposer;
    import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;

    public class TradingModel implements IInventoryModel, IGetImageListener
    {

        public static const MAX_ITEMS_TO_TRADE:uint = 9;
        public static const TRADING_STATE_READY:uint = 0;
        public static const TRADING_STATE_RUNNING:uint = 1;
        public static const TRADING_STATE_COUNTDOWN:uint = 2;
        public static const TRADING_STATE_CONFIRMING:uint = 3;
        public static const TRADING_STATE_CONFIRMED:uint = 4;
        public static const TRADING_STATE_COMPLETED:uint = 5;
        public static const TRADING_STATE_CANCELLED:uint = 6;

        private var _inventory:HabboInventory;
        private var _SafeStr_1354:IAssetLibrary;
        private var _roomEngine:IRoomEngine;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _soundManager:IHabboSoundManager;
        private var _SafeStr_2772:TradingView;
        private var _disposed:Boolean = false;
        private var _SafeStr_801:Boolean = false;
        private var _state:uint = 0;
        private var _ownUserId:int = -1;
        private var _ownUserName:String = "";
        private var _ownUserItems:Map;
        private var _ownUserNumItems:int = 0;
        private var _ownUserNumCredits:int = 0;
        private var _ownUserAccepts:Boolean = false;
        private var _ownUserCanTrade:Boolean = false;
        private var _otherUserId:int = -1;
        private var _otherUserName:String = "";
        private var _otherUserItems:Map;
        private var _otherUserNumItems:int = 0;
        private var _otherUserNumCredits:int = 0;
        private var _otherUserAccepts:Boolean = false;
        private var _otherUserCanTrade:Boolean = false;

        public function TradingModel(_arg_1:HabboInventory, _arg_2:IHabboWindowManager, _arg_3:IHabboCommunicationManager, _arg_4:IAssetLibrary, _arg_5:IRoomEngine, _arg_6:IHabboLocalizationManager, _arg_7:IHabboSoundManager)
        {
            _inventory = _arg_1;
            _communication = _arg_3;
            _SafeStr_1354 = _arg_4;
            _roomEngine = _arg_5;
            _localization = _arg_6;
            _soundManager = _arg_7;
            _SafeStr_2772 = new TradingView(this, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7);
        }

        public static function getGuildFurniType(_arg_1:int, _arg_2:IStuffData):String
        {
            var _local_5:int;
            var _local_4:String = _arg_1.toString();
            var _local_3:StringArrayStuffData = (_arg_2 as StringArrayStuffData);
            if (!_local_3)
            {
                return (_local_4);
            };
            _local_5 = 1;
            while (_local_5 < 5)
            {
                _local_4 = (_local_4 + ("," + _local_3.getValue(_local_5)));
                _local_5++;
            };
            return (_local_4);
        }


        public function get running():Boolean
        {
            return (!(_state == 0));
        }

        public function get state():uint
        {
            return (_state);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get ownUserId():int
        {
            return (_ownUserId);
        }

        public function get ownUserName():String
        {
            return (_ownUserName);
        }

        public function get ownUserItems():Map
        {
            return (_ownUserItems);
        }

        public function get ownUserAccepts():Boolean
        {
            return (_ownUserAccepts);
        }

        public function get ownUserCanTrade():Boolean
        {
            return (_ownUserCanTrade);
        }

        public function get otherUserId():int
        {
            return (_otherUserId);
        }

        public function get otherUserName():String
        {
            return (_otherUserName);
        }

        public function get otherUserItems():Map
        {
            return (_otherUserItems);
        }

        public function get otherUserAccepts():Boolean
        {
            return (_otherUserAccepts);
        }

        public function get otherUserCanTrade():Boolean
        {
            return (_otherUserCanTrade);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (((_SafeStr_2772) && (!(_SafeStr_2772.disposed))))
                {
                    _SafeStr_2772.dispose();
                    _SafeStr_2772 = null;
                };
                _inventory = null;
                _communication = null;
                _SafeStr_1354 = null;
                _roomEngine = null;
                _localization = null;
                _disposed = true;
            };
        }

        public function startTrading(_arg_1:int, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:String, _arg_6:Boolean):void
        {
            _ownUserId = _arg_1;
            _ownUserName = _arg_2;
            _ownUserItems = new Map();
            _ownUserAccepts = false;
            _ownUserCanTrade = _arg_3;
            _otherUserId = _arg_4;
            _otherUserName = _arg_5;
            _otherUserItems = new Map();
            _otherUserAccepts = false;
            _otherUserCanTrade = _arg_6;
            _SafeStr_801 = true;
            state = 1;
            _SafeStr_2772.setup(_arg_1, _arg_3, _arg_4, _arg_6);
            _SafeStr_2772.updateItemList(_ownUserId);
            _SafeStr_2772.updateItemList(_otherUserId);
            _SafeStr_2772.updateUserInterface();
            _SafeStr_2772.clearItemLists();
            _inventory.toggleInventoryPage("furni");
            _inventory.events.dispatchEvent(new Event("HABBO_INVENTORY_TRACKING_EVENT_TRADING"));
        }

        public function close():void
        {
            if (_SafeStr_801)
            {
                if (((!(_state == 0)) && (!(_state == 5))))
                {
                    requestCancelTrading();
                    state = 6;
                };
                state = 0;
                _inventory.toggleInventorySubPage("empty");
                _SafeStr_801 = false;
            };
            _SafeStr_2772.setMinimized(false);
        }

        public function categorySwitch(_arg_1:String):void
        {
            _SafeStr_2772.setMinimized((!(_arg_1 == "furni")));
            _inventory.updateSubView();
        }

        public function set state(_arg_1:uint):void
        {
            Logger.log(((((((("OLD STATE: " + _state) + " NEW STATE: ") + _arg_1) + " OWN: ") + _ownUserAccepts) + " OTHER: ") + _otherUserAccepts));
            var _local_2:Boolean;
            if (_state == _arg_1)
            {
                return;
            };
            switch (_state)
            {
                case 0:
                    if (((_arg_1 == 1) || (_arg_1 == 5)))
                    {
                        _state = _arg_1;
                        _local_2 = true;
                    };
                    break;
                case 1:
                    if (_arg_1 == 2)
                    {
                        _state = _arg_1;
                        _local_2 = true;
                        startConfirmCountdown();
                    }
                    else
                    {
                        if (_arg_1 == 6)
                        {
                            _state = _arg_1;
                            _SafeStr_2772.setMinimized(false);
                            _local_2 = true;
                        };
                    };
                    break;
                case 2:
                    if (_arg_1 == 3)
                    {
                        _state = _arg_1;
                        _local_2 = true;
                    }
                    else
                    {
                        if (_arg_1 == 6)
                        {
                            _state = _arg_1;
                            _SafeStr_2772.setMinimized(false);
                            _local_2 = true;
                        }
                        else
                        {
                            if (_arg_1 == 1)
                            {
                                _state = _arg_1;
                                _local_2 = true;
                                cancelConfirmCountdown();
                            };
                        };
                    };
                    break;
                case 3:
                    if (_arg_1 == 4)
                    {
                        _state = _arg_1;
                        _local_2 = true;
                    }
                    else
                    {
                        if (_arg_1 == 5)
                        {
                            _state = _arg_1;
                            _local_2 = true;
                            close();
                        }
                        else
                        {
                            if (_arg_1 == 6)
                            {
                                _state = _arg_1;
                                _SafeStr_2772.setMinimized(false);
                                _local_2 = true;
                                close();
                            };
                        };
                    };
                    break;
                case 4:
                    if (_arg_1 == 5)
                    {
                        _state = _arg_1;
                        _SafeStr_2772.setMinimized(false);
                        _local_2 = true;
                        close();
                    }
                    else
                    {
                        if (_arg_1 == 6)
                        {
                            _state = _arg_1;
                            _SafeStr_2772.setMinimized(false);
                            _local_2 = true;
                            close();
                        };
                    };
                    break;
                case 5:
                    if (_arg_1 == 0)
                    {
                        _state = _arg_1;
                        _local_2 = true;
                    };
                    break;
                case 6:
                    if (_arg_1 == 0)
                    {
                        _state = _arg_1;
                        _local_2 = true;
                    }
                    else
                    {
                        if (_arg_1 == 1)
                        {
                            _state = _arg_1;
                            _local_2 = true;
                        };
                    };
                    break;
                default:
                    throw (new Error((('Unknown trading progress state: "' + _state) + '"')));
            };
            if (_local_2)
            {
                _SafeStr_2772.updateUserInterface();
            }
            else
            {
                throw (new Error(((("Error assigning trading process status! States does not match: (from) " + _state) + " (to) ") + _arg_1)));
            };
        }

        public function getFurniInventoryModel():FurniModel
        {
            return (_inventory.furniModel);
        }

        public function getInventory():HabboInventory
        {
            return (_inventory);
        }

        public function updateItemGroupMaps(_arg_1:TradingItemListEvent, _arg_2:Map, _arg_3:Map):void
        {
            if (_inventory == null)
            {
                return;
            };
            if (_ownUserItems != null)
            {
                _ownUserItems.dispose();
            };
            if (_otherUserItems != null)
            {
                _otherUserItems.dispose();
            };
            if (_arg_1.firstUserID == _ownUserId)
            {
                _ownUserItems = _arg_2;
                _ownUserNumItems = _arg_1.firstUserNumItems;
                _ownUserNumCredits = _arg_1.firstUserNumCredits;
                _otherUserItems = _arg_3;
                _otherUserNumItems = _arg_1.secondUserNumItems;
                _otherUserNumCredits = _arg_1.secondUserNumCredits;
            }
            else
            {
                _ownUserItems = _arg_3;
                _ownUserNumItems = _arg_1.secondUserNumItems;
                _ownUserNumCredits = _arg_1.secondUserNumCredits;
                _otherUserItems = _arg_2;
                _otherUserNumItems = _arg_1.firstUserNumItems;
                _otherUserNumCredits = _arg_1.firstUserNumCredits;
            };
            _ownUserAccepts = false;
            _otherUserAccepts = false;
            _SafeStr_2772.updateItemList(_ownUserId);
            _SafeStr_2772.updateItemList(_otherUserId);
            _SafeStr_2772.updateUserInterface();
            var _local_4:FurniModel = _inventory.furniModel;
            if (_local_4 != null)
            {
                _local_4.updateItemLocks();
            };
        }

        public function getOwnItemIdsInTrade():Array
        {
            var _local_5:GroupItem;
            var _local_2:IFurnitureItem;
            var _local_3:int;
            var _local_4:int;
            var _local_1:Array = [];
            if (((_ownUserItems == null) || (_ownUserItems.disposed)))
            {
                return (_local_1);
            };
            _local_3 = 0;
            while (_local_3 < _ownUserItems.length)
            {
                _local_5 = (_ownUserItems.getWithIndex(_local_3) as GroupItem);
                if (_local_5 != null)
                {
                    _local_4 = 0;
                    while (_local_4 < _local_5.getTotalCount())
                    {
                        _local_2 = _local_5.getAt(_local_4);
                        if (_local_2 != null)
                        {
                            _local_1.push(_local_2.ref);
                        };
                        _local_4++;
                    };
                };
                _local_3++;
            };
            return (_local_1);
        }

        public function get ownUserNumItems():int
        {
            return (_ownUserNumItems);
        }

        public function get ownUserNumCredits():int
        {
            return (_ownUserNumCredits);
        }

        public function get otherUserNumItems():int
        {
            return (_otherUserNumItems);
        }

        public function get otherUserNumCredits():int
        {
            return (_otherUserNumCredits);
        }

        public function getWindowContainer():IWindowContainer
        {
            return (_SafeStr_2772.getWindowContainer());
        }

        public function requestInitialization():void
        {
        }

        public function subCategorySwitch(_arg_1:String):void
        {
            if (_SafeStr_801)
            {
                if (_state != 0)
                {
                    requestCancelTrading();
                };
            };
        }

        public function closingInventoryView():void
        {
            if (_SafeStr_801)
            {
                close();
            };
        }

        public function startConfirmCountdown():void
        {
            _SafeStr_2772.startConfirmCountdown();
        }

        public function cancelConfirmCountdown():void
        {
            _SafeStr_2772.cancelConfirmCountdown();
        }

        public function confirmCountdownReady():void
        {
            if (_state == 2)
            {
                state = 3;
            };
        }

        public function getItemImage(_arg_1:FurnitureItem):BitmapData
        {
            var _local_2:_SafeStr_147;
            if (!_arg_1.isWallItem)
            {
                _local_2 = _roomEngine.getFurnitureImage(_arg_1.type, new Vector3d(180, 0, 0), 64, this, 0, String(_arg_1.extra), -1, -1, _arg_1.stuffData);
            }
            else
            {
                _local_2 = _roomEngine.getWallItemImage(_arg_1.type, new Vector3d(180, 0, 0), 64, this, 0, _arg_1.stuffData.getLegacyString());
            };
            return (_local_2.data as BitmapData);
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            _SafeStr_2772.updateItemImage(_arg_1, _arg_2);
        }

        public function imageFailed(_arg_1:int):void
        {
        }

        public function handleMessageEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingCloseEvent;
            if ((_arg_1 is TradeOpenFailedEvent))
            {
                Logger.log("TRADING::TradingOpenFailedEvent");
                if (((TradeOpenFailedEvent(_arg_1).getParser().reason == 7) || (TradeOpenFailedEvent(_arg_1).getParser().reason == 8)))
                {
                    _SafeStr_2772.alertPopup(2);
                }
                else
                {
                    _SafeStr_2772.alertTradeOpenFailed(TradeOpenFailedEvent(_arg_1));
                };
            }
            else
            {
                if ((_arg_1 is TradingAcceptEvent))
                {
                    Logger.log("TRADING::TradingAcceptEvent");
                    if (TradingAcceptEvent(_arg_1).userID == _ownUserId)
                    {
                        _ownUserAccepts = (!(TradingAcceptEvent(_arg_1).userAccepts == 0));
                    }
                    else
                    {
                        _otherUserAccepts = (!(TradingAcceptEvent(_arg_1).userAccepts == 0));
                    };
                    _SafeStr_2772.updateUserInterface();
                }
                else
                {
                    if ((_arg_1 is TradingConfirmationEvent))
                    {
                        Logger.log("TRADING::TradingConfirmationEvent");
                        state = 2;
                    }
                    else
                    {
                        if ((_arg_1 is TradingCompletedEvent))
                        {
                            Logger.log("TRADING::TradingCompletedEvent");
                            state = 5;
                        }
                        else
                        {
                            if ((_arg_1 is TradingCloseEvent))
                            {
                                Logger.log("TRADING::TradingCloseEvent");
                                if (!_SafeStr_801)
                                {
                                    Logger.log("Received TradingCloseEvent, but trading already stopped!!!");
                                    return;
                                };
                                _local_2 = (_arg_1 as TradingCloseEvent);
                                if (_local_2.getParser().reason == 1)
                                {
                                    if (_inventory.getBoolean("trading.commiterror.enabled"))
                                    {
                                        _SafeStr_2772.windowManager.simpleAlert("${inventory.trading.notification.title}", "${inventory.trading.notification.commiterror.caption}", "${inventory.trading.notification.commiterror.info}");
                                    };
                                }
                                else
                                {
                                    if (_local_2.getParser().userID != _ownUserId)
                                    {
                                        _SafeStr_2772.alertPopup(1);
                                    };
                                };
                                close();
                            }
                            else
                            {
                                if ((_arg_1 is TradingNotOpenEvent))
                                {
                                    Logger.log("TRADING::TradingNotOpenEvent");
                                }
                                else
                                {
                                    if ((_arg_1 is TradingOtherNotAllowedEvent))
                                    {
                                        _SafeStr_2772.showOtherUserNotification("${inventory.trading.warning.others_account_disabled}");
                                    }
                                    else
                                    {
                                        if ((_arg_1 is TradingYouAreNotAllowedEvent))
                                        {
                                            _SafeStr_2772.showOwnUserNotification("${inventory.trading.warning.own_account_disabled}");
                                        }
                                        else
                                        {
                                            Logger.log(("TRADING/Unknown message event: " + _arg_1));
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function requestFurniViewOpen():void
        {
            _inventory.toggleInventoryPage("furni");
        }

        public function requestOpenTrading(_arg_1:int):void
        {
            _communication.connection.send(new OpenTradingComposer(_arg_1));
        }

        public function requestAddItemsToTrading(_arg_1:Vector.<int>, _arg_2:Boolean, _arg_3:int, _arg_4:int, _arg_5:Boolean, _arg_6:IStuffData):void
        {
            var _local_8:Vector.<int> = undefined;
            if (((!(_arg_5)) && (_arg_1.length > 0)))
            {
                _communication.connection.send(new AddItemToTradeComposer(_arg_1.pop()));
            }
            else
            {
                _local_8 = new Vector.<int>();
                for each (var _local_7:int in _arg_1)
                {
                    if (canAddItemToTrade(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6))
                    {
                        _local_8.push(_local_7);
                    };
                };
                if (_local_8.length > 0)
                {
                    if (_local_8.length == 1)
                    {
                        _communication.connection.send(new AddItemToTradeComposer(_local_8.pop()));
                    }
                    else
                    {
                        _communication.connection.send(new AddItemsToTradeComposer(_local_8));
                    };
                };
            };
        }

        public function canAddItemToTrade(_arg_1:Boolean, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:IStuffData):Boolean
        {
            var _local_6:String;
            if (_ownUserAccepts)
            {
                return (false);
            };
            if (_ownUserItems == null)
            {
                return (false);
            };
            if (_ownUserItems.length < 9)
            {
                return (true);
            };
            if (!_arg_4)
            {
                return (false);
            };
            _local_6 = String(_arg_2);
            if (_arg_3 == 6)
            {
                _local_6 = ((String(_arg_2) + "poster") + _arg_5.getLegacyString());
            }
            else
            {
                if (_arg_3 == 17)
                {
                    _local_6 = getGuildFurniType(_arg_2, _arg_5);
                }
                else
                {
                    _local_6 = (((_arg_1) ? "I" : "S") + _local_6);
                };
            };
            return (!(_ownUserItems.getValue(_local_6) == null));
        }

        public function requestRemoveItemFromTrading(_arg_1:int):void
        {
            var _local_2:IFurnitureItem;
            if (_ownUserAccepts)
            {
                return;
            };
            var _local_3:GroupItem = ownUserItems.getWithIndex(_arg_1);
            if (_local_3)
            {
                _local_2 = _local_3.peek();
                if (_local_2)
                {
                    _communication.connection.send(new RemoveItemFromTradeComposer(_local_2.id));
                };
            };
        }

        public function requestAcceptTrading():void
        {
            _communication.connection.send(new AcceptTradingComposer());
        }

        public function requestUnacceptTrading():void
        {
            _communication.connection.send(new UnacceptTradingComposer());
        }

        public function requestConfirmAcceptTrading():void
        {
            state = 4;
            _communication.connection.send(new ConfirmAcceptTradingComposer());
        }

        public function requestConfirmDeclineTrading():void
        {
            _communication.connection.send(new ConfirmDeclineTradingComposer());
        }

        public function requestCancelTrading():void
        {
            _communication.connection.send(new CloseTradingComposer());
        }

        public function isCreditFurniPresent():Boolean
        {
            return ((_ownUserNumCredits > 0) || (_otherUserNumCredits > 0));
        }

        private function get citizenshipTalentTrackEnabled():Boolean
        {
            return (_inventory.getBoolean("talent.track.citizenship.enabled"));
        }

        public function updateView():void
        {
        }

        public function selectItemById(_arg_1:String):void
        {
            Logger.log("NOT SUPPORTED: TRADING VIEW SELECT BY ID");
        }


    }
}