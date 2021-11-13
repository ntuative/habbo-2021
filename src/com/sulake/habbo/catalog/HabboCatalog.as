package com.sulake.habbo.catalog
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.navigator.IHabboNewNavigator;
    import com.sulake.habbo.avatar.IHabboAvatarEditor;
    import com.sulake.habbo.quest.IHabboQuestEngine;
    import com.sulake.habbo.catalog.viewer.CatalogViewer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.catalog.purse.Purse;
    import com.sulake.habbo.catalog.marketplace.IMarketPlace;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.purchase.PurchaseConfirmationDialog;
    import com.sulake.habbo.catalog.purchase.GiftWrappingConfiguration;
    import com.sulake.habbo.catalog.club.ClubGiftController;
    import com.sulake.habbo.catalog.club.ClubBuyController;
    import com.sulake.habbo.catalog.club.ClubExtendController;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import com.sulake.habbo.catalog.purchase.PlacedObjectPurchaseData;
    import com.sulake.habbo.room.preview.RoomPreviewer;
    import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
    import com.sulake.habbo.catalog.targetedoffers.OfferController;
    import com.sulake.habbo.catalog.viewer.GameTokensOffer;
    import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRuleset;
    import com.sulake.habbo.catalog.navigation.RequestedPage;
    import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
    import com.sulake.habbo.catalog.purchase.RentConfirmationWindow;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.communication.messages.incoming.catalog.FrontPageItem;
    import flash.utils.Timer;
    import com.sulake.habbo.catalog.offers.OfferCenter;
    import com.sulake.habbo.catalog.clubcenter.HabboClubCenter;
    import com.sulake.iid.IIDHabboClubCenter;
    import com.sulake.habbo.catalog.vault.VaultController;
    import com.sulake.iid.IIDVaultController;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboNewNavigator;
    import com.sulake.iid.IIDHabboFriendBar;
    import com.sulake.iid.IIDHabboGroupsManager;
    import com.sulake.iid.IIDHabboAvatarEditor;
    import com.sulake.iid.IIDHabboQuestEngine;
    import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceBuyOfferResultEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffersEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubFurniCountMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseErrorMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseOKMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.SellablePetPalettesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboActivityPointNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCancelOfferResultEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.GiftReceiverNotFoundEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ApproveNameMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.LimitedEditionSoldOutEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.PurchaseNotAllowedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.VoucherRedeemOkMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.BundleDiscountRulesetMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.ActivityPointsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOwnOffersEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogIndexMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPublishedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.SnowWarGameTokensMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.BuildersClubSubscriptionStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.ProductOfferEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubOffersMessageEvent;
    import com.sulake.habbo.catalog.event.CatalogEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubQueryFurniCountMessageComposer;
    import com.sulake.habbo.catalog.navigation.ICatalogNavigator;
    import com.sulake.core.Core;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseSnowWarGameTokensOfferComposer;
    import com.sulake.habbo.catalog.navigation.ICatalogNode;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseRoomAdMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseVipMembershipExtensionComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseBasicMembershipExtensionComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseFromCatalogAsGiftComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.ApproveNameMessageComposer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.club.ClubBuyOfferData;
    import com.sulake.habbo.room.IStuffData;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetRoomAdPurchaseInfoComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.RoomAdPurchaseInitiatedComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceOwnOffersMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.RedeemMarketplaceOfferCreditsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.CancelMarketplaceOfferMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSellablePetPalettesComposer;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogIndexComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.MarkCatalogNewAdditionsPageOpenedComposer;
    import com.sulake.habbo.catalog.navigation.CatalogNavigator;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.catalog.marketplace.MarketPlaceLogic;
    import com.sulake.habbo.communication.messages.outgoing.catalog._SafeStr_48;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubOffersMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageMessageParser;
    import com.sulake.habbo.catalog.viewer.PageLocalization;
    import com.sulake.habbo.catalog.viewer.IPageLocalization;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.catalog.viewer.Product;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseNotAllowedMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.PurchaseOKMessageParser;
    import com.sulake.habbo.catalog.navigation.events.CatalogFurniPurchaseEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.NotEnoughBalanceMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.ApproveNameMessageParser;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.purse.CreditBalanceParser;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftInfoParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;
    import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetPalettesParser;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.window.utils._SafeStr_126;
    import com.sulake.habbo.communication.messages.outgoing.catalog.RedeemVoucherMessageComposer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.catalog.event.CatalogUserEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectEvent;
    import com.sulake.habbo.friendbar.events.FriendBarSelectionEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedOnUserEvent;
    import com.sulake.room.object.IRoomObjectController;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.object.data.LegacyStuffData;
    import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceRoomItemMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceWallItemMessageComposer;
    import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
    import com.sulake.habbo.inventory.events.HabboInventoryItemAddedEvent;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokensMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.SnowWarGameTokenOffer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;
    import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetIsOfferGiftableComposer;
    import com.sulake.habbo.communication.messages.outgoing.catalog._SafeStr_31;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetProductOfferComposer;
    import com.sulake.habbo.communication.messages.parser.catalog.BundleDiscountRulesetMessageParser;
    import com.sulake.habbo.communication.messages.parser.catalog.ProductOfferMessageParser;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.BuildersClubSubscriptionStatusMessageParser;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBuilderSubscriptionUpdatedEvent;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.habbo.utils.FurniId;
    import com.sulake.habbo.catalog.offers.IOfferExtension;
    import com.sulake.habbo.catalog.offers.IOfferCenter;
    import com.sulake.iid.*;

    public class HabboCatalog extends Component implements IHabboCatalog, IProductDataListener, IUpdateReceiver, ILinkEventTracker, IFurniDataListener
    {

        public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
        public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
        public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
        private static const DESKTOP_WINDOW_LAYER:uint = 1;
        private static const DEFAULT_VIEW_LOCATION:Point = new Point(100, 20);
        private static const DEFAULT_VIEW_LOCATION_LARGE:Point = new Point(100, 5);
        private static const MAX_SEARCH_RESULTS_LENGTH:uint = 200;
        private static const NO_KNOWN_OFFER:int = -1;

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _toolbar:IHabboToolbar;
        private var _roomEngine:IRoomEngine;
        private var _roomSessionManager:IRoomSessionManager;
        private var _roomSession:IRoomSession;
        private var _localization:IHabboLocalizationManager;
        private var _inventory:IHabboInventory;
        private var _sessionDataManager:ISessionDataManager;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _soundManager:IHabboSoundManager;
        private var _friendList:IHabboFriendList;
        private var _newNavigator:IHabboNewNavigator;
        private var _avatarEditor:IHabboAvatarEditor;
        private var _questEngine:IHabboQuestEngine;
        private var _videoOffers:VideoOfferManager;
        private var _SafeStr_527:Boolean = false;
        private var _SafeStr_510:Boolean = false;
        private var _SafeStr_528:CatalogViewer;
        private var _catalogNavigators:Dictionary;
        private var _SafeStr_529:Purse;
        private var _SafeStr_533:IMarketPlace;
        private var _mainContainer:IWindowContainer;
        private var _SafeStr_516:PurchaseConfirmationDialog;
        private var _SafeStr_531:String;
        private var _SafeStr_530:Boolean;
        private var _SafeStr_540:Boolean = true;
        private var _privateRoomSessionActive:Boolean = false;
        private var _giftWrappingConfiguration:GiftWrappingConfiguration;
        private var _SafeStr_534:ClubGiftController;
        private var _SafeStr_517:ClubBuyController;
        private var _SafeStr_518:ClubExtendController;
        private var _SafeStr_519:Map = new Map();
        private var _SafeStr_539:Boolean = false;
        private var _offerInFurniPlacing:IPurchasableOffer;
        private var _offerPlacingCallbackReceiver:IDragAndDropDoneReceiver;
        private var _SafeStr_543:PlacedObjectPurchaseData;
        private var _SafeStr_535:Boolean;
        private var _SafeStr_538:Boolean;
        private var _SafeStr_515:RoomPreviewer;
        private var _SafeStr_521:GuildMembershipsController;
        private var _SafeStr_523:OfferController;
        private var _utils:HabboCatalogUtils;
        private var _SafeStr_544:Boolean = false;
        private var _SafeStr_541:String = null;
        private var _SafeStr_524:GameTokensOffer;
        private var _SafeStr_525:GameTokensOffer;
        private var _SafeStr_526:GameTokensOffer;
        private var _bundleDiscountRuleset:BundleDiscountRuleset = null;
        private var _SafeStr_522:RequestedPage;
        private var _SafeStr_532:int;
        private var _roomAdPurchaseData:RoomAdPurchaseData;
        private var _SafeStr_520:RentConfirmationWindow;
        private var _messageEvents:Vector.<IMessageEvent>;
        private var _catalogType:String = "NORMAL";
        private var _SafeStr_537:Vector.<IFurnitureData>;
        private var _frontPageItems:Vector.<FrontPageItem>;
        private var _SafeStr_536:Timer;
        private var _SafeStr_1655:Dictionary;
        private var _SafeStr_542:Boolean;
        private var _builderFurniCount:int = -1;
        private var _builderFurniLimit:int;
        private var _builderMaxFurniLimit:int;
        private var _SafeStr_545:int;
        private var _SafeStr_546:int;
        private var _builderMembershipUpdateTime:int;
        private var _builderMembershipDisplayUpdateTime:int;
        private var _SafeStr_547:Boolean;
        private var _SafeStr_548:Boolean;
        private var _offerCenter:OfferCenter;

        public function HabboCatalog(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _SafeStr_529 = new Purse();
            _utils = new HabboCatalogUtils(this);
            registerUpdateReceiver(this, 1);
            _SafeStr_522 = new RequestedPage();
            _arg_1.attachComponent(new HabboClubCenter(_arg_1, 0, _arg_3), [new IIDHabboClubCenter()]);
            _arg_1.attachComponent(new VaultController(_arg_1, 0, _arg_3), [new IIDVaultController()]);
        }

        public static function setElementImageCentered(_arg_1:IWindow, _arg_2:BitmapData, _arg_3:int=0):void
        {
            var _local_7:IBitmapWrapperWindow;
            var _local_4:IDisplayObjectWrapper;
            if (_arg_2 == null)
            {
                return;
            };
            if (_arg_1 == null)
            {
                return;
            };
            if (_arg_1.disposed)
            {
                return;
            };
            var _local_8:int = ((_arg_3 > 0) ? _arg_3 : _arg_1.height);
            var _local_5:int = int(((_arg_1.width - _arg_2.width) / 2));
            var _local_6:int = int(((_local_8 - _arg_2.height) / 2));
            if ((_arg_1 as IBitmapWrapperWindow) != null)
            {
                _local_7 = IBitmapWrapperWindow(_arg_1);
                if (((_local_7.bitmap == null) || (_arg_3 > 0)))
                {
                    _local_7.bitmap = new BitmapData(_arg_1.width, _local_8, true, 0xFFFFFF);
                };
                _local_7.bitmap.fillRect(_local_7.bitmap.rect, 0xFFFFFF);
                _local_7.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_5, _local_6), null, null, false);
                _arg_1.invalidate();
            }
            else
            {
                if ((_arg_1 as IDisplayObjectWrapper) != null)
                {
                    _local_4 = IDisplayObjectWrapper(_arg_1);
                    _local_4.setDisplayObject(new Bitmap(_arg_2));
                    _arg_1.invalidate();
                };
            };
        }


        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (_avatarRenderManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get connection():IConnection
        {
            return (_communication.connection);
        }

        public function get toolbar():IHabboToolbar
        {
            return (_toolbar);
        }

        public function get giftWrappingConfiguration():GiftWrappingConfiguration
        {
            return (_giftWrappingConfiguration);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        public function get soundManager():IHabboSoundManager
        {
            return (_soundManager);
        }

        public function get roomPreviewer():RoomPreviewer
        {
            if (_SafeStr_515 == null)
            {
                initializeRoomPreviewer();
            };
            return (_SafeStr_515);
        }

        public function get navigator():IHabboNavigator
        {
            return (_newNavigator.legacyNavigator);
        }

        public function get utils():HabboCatalogUtils
        {
            return (_utils);
        }

        public function get questEngine():IHabboQuestEngine
        {
            return (_questEngine);
        }

        public function get videoOffers():IVideoOfferManager
        {
            return (_videoOffers);
        }

        public function get frontPageItems():Vector.<FrontPageItem>
        {
            return (_frontPageItems);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboToolbar(), function (_arg_1:IHabboToolbar):void
            {
                _toolbar = _arg_1;
            }, false, [{
                "type":"HTE_TOOLBAR_CLICK",
                "callback":onHabboToolbarEvent
            }]), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }, false, [{
                "type":"REOE_PLACED",
                "callback":onObjectPlacedInRoom
            }, {
                "type":"REOE_PLACED_ON_USER",
                "callback":onObjectPlaceOnUser
            }, {
                "type":"REOE_SELECTED",
                "callback":onObjectSelected
            }]), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }, false), new ComponentDependency(new IIDHabboInventory(), function (_arg_1:IHabboInventory):void
            {
                _inventory = _arg_1;
            }, false, [{
                "type":"HABBO_INVENTORY_ITEM_ADDED",
                "callback":onItemAddedToInventory
            }]), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            }), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboSoundManager(), function (_arg_1:IHabboSoundManager):void
            {
                _soundManager = _arg_1;
            }, false), new ComponentDependency(new IIDHabboRoomSessionManager(), function (_arg_1:IRoomSessionManager):void
            {
                _roomSessionManager = _arg_1;
            }, false, [{
                "type":"RSE_STARTED",
                "callback":onRoomSessionEvent
            }, {
                "type":"RSE_ENDED",
                "callback":onRoomSessionEvent
            }]), new ComponentDependency(new IIDHabboFriendList(), function (_arg_1:IHabboFriendList):void
            {
                _friendList = _arg_1;
            }, false), new ComponentDependency(new IIDHabboNewNavigator(), function (_arg_1:IHabboNewNavigator):void
            {
                _newNavigator = _arg_1;
            }, false), new ComponentDependency(new IIDHabboFriendBar(), null, false, [{
                "type":"FBVE_FRIEND_SELECTED",
                "callback":onFriendBarSelectionEvent
            }]), new ComponentDependency(new IIDHabboGroupsManager(), null, false, [{
                "type":"GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",
                "callback":onGuildVisualSettingsChanged
            }]), new ComponentDependency(new IIDHabboAvatarEditor(), function (_arg_1:IHabboAvatarEditor):void
            {
                _avatarEditor = _arg_1;
            }, false), new ComponentDependency(new IIDHabboQuestEngine(), function (_arg_1:IHabboQuestEngine):void
            {
                _questEngine = _arg_1;
            }, false)]));
        }

        override protected function initComponent():void
        {
            _messageEvents = new Vector.<IMessageEvent>(0);
            addMessageEvent(new GuildMembershipsMessageEvent(onGuildMemberships));
            addMessageEvent(new MarketplaceBuyOfferResultEvent(onMarketPlaceBuyResult));
            addMessageEvent(new VoucherRedeemErrorMessageEvent(onVoucherRedeemError));
            addMessageEvent(new MarketPlaceOffersEvent(onMarketPlaceOffers));
            addMessageEvent(new NotEnoughBalanceMessageEvent(onNotEnoughBalance));
            addMessageEvent(new GiftWrappingConfigurationEvent(onGiftWrappingConfiguration));
            addMessageEvent(new BuildersClubFurniCountMessageEvent(onBuildersClubFurniCount));
            addMessageEvent(new PurchaseErrorMessageEvent(onPurchaseError));
            addMessageEvent(new ClubGiftInfoEvent(onClubGiftInfo));
            addMessageEvent(new PurchaseOKMessageEvent(onPurchaseOK));
            addMessageEvent(new CreditBalanceEvent(onCreditBalance));
            addMessageEvent(new SellablePetPalettesMessageEvent(onSellablePalettes));
            addMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
            addMessageEvent(new HabboActivityPointNotificationMessageEvent(onActivityPointNotification));
            addMessageEvent(new MarketplaceCancelOfferResultEvent(onMarketPlaceCancelResult));
            addMessageEvent(new HabboClubExtendOfferMessageEvent(onHabboClubExtendOffer));
            addMessageEvent(new GiftReceiverNotFoundEvent(onGiftReceiverNotFound));
            addMessageEvent(new ApproveNameMessageEvent(onApproveNameResult));
            addMessageEvent(new CloseConnectionMessageEvent(onRoomExit));
            addMessageEvent(new LimitedEditionSoldOutEvent(onLimitedEditionSoldOut));
            addMessageEvent(new PurchaseNotAllowedMessageEvent(onPurchaseNotAllowed));
            addMessageEvent(new CatalogPageMessageEvent(onCatalogPage));
            addMessageEvent(new VoucherRedeemOkMessageEvent(onVoucherRedeemOk));
            addMessageEvent(new MarketplaceItemStatsEvent(onMarketplaceItemStats));
            addMessageEvent(new BundleDiscountRulesetMessageEvent(onBundleDiscountRulesetMessageEvent));
            addMessageEvent(new ActivityPointsMessageEvent(onActivityPoints));
            addMessageEvent(new MarketplaceMakeOfferResult(onMarketplaceMakeOfferResult));
            addMessageEvent(new MarketPlaceOwnOffersEvent(onMarketPlaceOwnOffers));
            addMessageEvent(new CatalogIndexMessageEvent(onCatalogIndex));
            addMessageEvent(new CatalogPublishedMessageEvent(onCatalogPublished));
            addMessageEvent(new SnowWarGameTokensMessageEvent(onSnowWarGameTokenOffer));
            addMessageEvent(new MarketplaceConfigurationEvent(onMarketplaceConfiguration));
            addMessageEvent(new BuildersClubSubscriptionStatusMessageEvent(onBuildersClubSubscriptionStatus));
            addMessageEvent(new ProductOfferEvent(onProductOffer));
            addMessageEvent(new HabboClubOffersMessageEvent(onHabboClubOffers));
            context.addLinkEventTracker(this);
            _sessionDataManager.loadProductData(this);
            _SafeStr_538 = isNewItemsNotificationEnabled();
            _videoOffers = new VideoOfferManager(this);
            _SafeStr_523 = new OfferController(this);
            _SafeStr_537 = _sessionDataManager.getFurniData(this);
            _SafeStr_1655 = null;
        }

        private function addMessageEvent(_arg_1:IMessageEvent):void
        {
            _messageEvents.push(_communication.addHabboConnectionMessageEvent(_arg_1));
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            removeUpdateReceiver(this);
            if (((!(_messageEvents == null)) && (!(_communication == null))))
            {
                for each (var _local_1:IMessageEvent in _messageEvents)
                {
                    _communication.removeHabboConnectionMessageEvent(_local_1);
                };
            };
            if (_videoOffers)
            {
                _videoOffers.dispose();
                _videoOffers = null;
            };
            if (_offerCenter != null)
            {
                _offerCenter.dispose();
                _offerCenter = null;
            };
            reset(true);
            context.removeLinkEventTracker(this);
            if (_SafeStr_516 != null)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
            _SafeStr_529 = null;
            _SafeStr_533 = null;
            if (_SafeStr_517 != null)
            {
                _SafeStr_517.dispose();
                _SafeStr_517 = null;
            };
            if (_SafeStr_518 != null)
            {
                _SafeStr_518.dispose();
                _SafeStr_518 = null;
            };
            if (_SafeStr_519 != null)
            {
                _SafeStr_519.dispose();
                _SafeStr_519 = null;
            };
            _roomSession = null;
            if (_SafeStr_520 != null)
            {
                _SafeStr_520.dispose();
                _SafeStr_520 = null;
            };
            resetPlacedOfferData();
            _SafeStr_539 = false;
            _offerPlacingCallbackReceiver = null;
            if (_SafeStr_515 != null)
            {
                _SafeStr_515.dispose();
                _SafeStr_515 = null;
            };
            if (_SafeStr_521 != null)
            {
                _SafeStr_521.dispose();
                _SafeStr_521 = null;
            };
            if (_utils != null)
            {
                _utils.dispose();
                _utils = null;
            };
            disposeSnowWarTokens();
            if (_SafeStr_522)
            {
                _SafeStr_522 = null;
            };
            if (_SafeStr_523)
            {
                _SafeStr_523.dispose();
                _SafeStr_523 = null;
            };
            super.dispose();
        }

        private function disposeSnowWarTokens():void
        {
            if (_SafeStr_524 != null)
            {
                _SafeStr_524.dispose();
                _SafeStr_524 = null;
            };
            if (_SafeStr_525 != null)
            {
                _SafeStr_525.dispose();
                _SafeStr_525 = null;
            };
            if (_SafeStr_526 != null)
            {
                _SafeStr_526.dispose();
                _SafeStr_526 = null;
            };
        }

        private function init():Boolean
        {
            if (((!(_SafeStr_527)) && (_SafeStr_510)))
            {
                createMainWindow();
                createCatalogNavigators();
                createCatalogViewer();
                _SafeStr_527 = true;
                updatePurse();
                createMarketPlace();
                createClubGiftController();
                getGiftWrappingConfiguration();
                createClubBuyController();
                createClubExtendController();
                createGroupMembershipsController();
                initBundleDiscounts();
                events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
                send(new BuildersClubQueryFurniCountMessageComposer());
                return (true);
            };
            return (false);
        }

        private function reset(_arg_1:Boolean=false):void
        {
            var _local_2:Boolean;
            _SafeStr_527 = false;
            if (_SafeStr_528 != null)
            {
                _SafeStr_528.dispose();
                _SafeStr_528 = null;
            };
            if (_catalogNavigators != null)
            {
                for each (var _local_3:ICatalogNavigator in _catalogNavigators)
                {
                    _local_3.dispose();
                };
                _catalogNavigators = null;
            };
            if (_mainContainer != null)
            {
                _mainContainer.dispose();
                _mainContainer = null;
            };
            if (!_arg_1)
            {
                if (_sessionDataManager == null)
                {
                    Core.crash("Could not reload product data after reset() because _sessionDataManager was null", 7);
                    return;
                };
                _local_2 = _sessionDataManager.loadProductData(this);
                if (_local_2)
                {
                    init();
                }
                else
                {
                    events.dispatchEvent(new CatalogEvent("CATALOG_NOT_READY"));
                };
            };
        }

        private function send(_arg_1:IMessageComposer):void
        {
            if (connection == null)
            {
                return;
            };
            connection.send(_arg_1);
        }

        public function loadCatalogPage(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            isBusy = true;
            _SafeStr_532 = _arg_1;
            send(new GetCatalogPageComposer(_arg_1, _arg_2, _arg_3));
        }

        public function purchaseGameTokensOffer(_arg_1:String):void
        {
            if (((_arg_1 == "GET_SNOWWAR_TOKENS") && (_SafeStr_524)))
            {
                send(new PurchaseSnowWarGameTokensOfferComposer(_SafeStr_524.offerId));
            }
            else
            {
                if (((_arg_1 == "GET_SNOWWAR_TOKENS2") && (_SafeStr_525)))
                {
                    send(new PurchaseSnowWarGameTokensOfferComposer(_SafeStr_525.offerId));
                }
                else
                {
                    if (((_arg_1 == "GET_SNOWWAR_TOKENS3") && (_SafeStr_526)))
                    {
                        send(new PurchaseSnowWarGameTokensOfferComposer(_SafeStr_526.offerId));
                    };
                };
            };
        }

        public function purchaseOffer(_arg_1:int, _arg_2:String="", _arg_3:int=1):void
        {
            var _local_4:Vector.<ICatalogNode> = undefined;
            var _local_5:ICatalogNavigator = getCatalogNavigator("NORMAL");
            if (_local_5 != null)
            {
                _local_4 = _local_5.getNodesByOfferId(_arg_1, true);
                if (_local_4 != null)
                {
                    purchaseProduct(_local_4[0].pageId, _arg_1, _arg_2, _arg_3);
                };
            };
        }

        public function purchaseProduct(_arg_1:int, _arg_2:int, _arg_3:String="", _arg_4:int=1):void
        {
            if (((roomAdPurchaseData == null) || (!(roomAdPurchaseData.offerId == _arg_2))))
            {
                send(new PurchaseFromCatalogComposer(_arg_1, _arg_2, _arg_3, _arg_4));
            }
            else
            {
                if (((_roomAdPurchaseData.extended) && (_roomAdPurchaseData.expirationTime.getTime() < new Date().getTime())))
                {
                    _roomAdPurchaseData.extended = false;
                };
                send(new PurchaseRoomAdMessageComposer(_arg_1, _arg_2, roomAdPurchaseData.flatId, roomAdPurchaseData.name, roomAdPurchaseData.extended, roomAdPurchaseData.description, roomAdPurchaseData.categoryId));
            };
        }

        public function purchaseVipMembershipExtension(_arg_1:int):void
        {
            send(new PurchaseVipMembershipExtensionComposer(_arg_1));
        }

        public function purchaseBasicMembershipExtension(_arg_1:int):void
        {
            send(new PurchaseBasicMembershipExtensionComposer(_arg_1));
        }

        public function purchaseProductAsGift(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:Boolean=false):void
        {
            send(new PurchaseFromCatalogAsGiftComposer(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9));
        }

        public function get roomAdPurchaseData():RoomAdPurchaseData
        {
            return (_roomAdPurchaseData);
        }

        public function set roomAdPurchaseData(_arg_1:RoomAdPurchaseData):void
        {
            _roomAdPurchaseData = _arg_1;
        }

        public function approveName(_arg_1:String, _arg_2:int):void
        {
            send(new ApproveNameMessageComposer(_arg_1, _arg_2));
        }

        public function set giftReceiver(_arg_1:String):void
        {
            _SafeStr_531 = _arg_1;
        }

        public function getSeasonalCurrencyActivityPointType():int
        {
            return (getInteger("seasonalcurrencyindicator.currency", 1));
        }

        public function showPurchaseConfirmation(_arg_1:IPurchasableOffer, _arg_2:int, _arg_3:String="", _arg_4:int=1, _arg_5:IStuffData=null, _arg_6:String=null, _arg_7:Boolean=true, _arg_8:BitmapData=null):void
        {
            var _local_14:Vector.<ICatalogNode> = undefined;
            var _local_11:Array;
            var _local_9:String;
            var _local_13:ICatalogNode;
            if (_arg_2 == -12345678)
            {
                _local_14 = currentCatalogNavigator.getNodesByOfferId(_arg_1.offerId, true);
                if (_local_14 != null)
                {
                    _arg_2 = _local_14[0].pageId;
                };
            };
            Logger.log(("buy: " + [_arg_4, _arg_1.offerId, _arg_3]));
            var _local_12:int = _arg_1.priceInCredits;
            var _local_15:int = _arg_1.priceInActivityPoints;
            if (multiplePurchaseEnabled)
            {
                _local_12 = _utils.calculateBundlePrice(true, _arg_1.priceInCredits, _arg_4);
                _local_15 = _utils.calculateBundlePrice(true, _arg_1.priceInActivityPoints, _arg_4);
            };
            var _local_10:Boolean = (_arg_1 is GameTokensOffer);
            if ((((_local_12 > 0) && (_local_12 > _SafeStr_529.credits)) && (!(_local_10))))
            {
                showNotEnoughCreditsAlert();
                return;
            };
            if ((((_local_15 > 0) && (_local_15 > _SafeStr_529.getActivityPointsForType(_arg_1.activityPointType))) && (!(_local_10))))
            {
                showNotEnoughActivityPointsAlert(_arg_1.activityPointType);
                return;
            };
            if ((((_arg_1 is Offer) || (_SafeStr_530)) || (_arg_1 is GameTokensOffer)))
            {
                if (((_SafeStr_516 == null) || (_SafeStr_516.disposed)))
                {
                    _SafeStr_516 = new PurchaseConfirmationDialog(_localization, assets);
                };
                _local_11 = [];
                if (_friendList != null)
                {
                    _local_11 = _friendList.getFriendNames();
                };
                _local_9 = _arg_6;
                if (_local_9 == null)
                {
                    if (_SafeStr_531 != null)
                    {
                        _local_9 = _SafeStr_531;
                    };
                };
                _SafeStr_516.showOffer(this, _roomEngine, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _local_11, _local_9, _arg_8);
            }
            else
            {
                if ((_arg_1 is ClubBuyOfferData))
                {
                    if (_arg_2 == -1)
                    {
                        _local_13 = currentCatalogNavigator.getNodeByName("hc_membership");
                        if (_local_13 != null)
                        {
                            _arg_2 = _local_13.pageId;
                        };
                    };
                    if (_arg_2 >= 0)
                    {
                        _SafeStr_517.showConfirmation((_arg_1 as ClubBuyOfferData), _arg_2);
                    };
                };
            };
            if (_SafeStr_530)
            {
                _SafeStr_530 = false;
                _SafeStr_516.turnIntoGifting();
            };
        }

        public function purchaseWillBeGift(_arg_1:Boolean):void
        {
            _SafeStr_530 = _arg_1;
        }

        private function initializeRoomPreviewer():void
        {
            if ((((!(_roomEngine == null)) && (_roomEngine.isInitialized)) && (getBoolean("catalog.furniture.animation"))))
            {
                if (_SafeStr_515 == null)
                {
                    _SafeStr_515 = new RoomPreviewer(_roomEngine);
                    _SafeStr_515.createRoomForPreviews();
                };
            };
        }

        private function isNewItemsNotificationEnabled():Boolean
        {
            return (getBoolean("toolbar.new_additions.notification.enabled"));
        }

        public function openCatalog():void
        {
            cancelFurniInMover();
            toggleCatalog("NORMAL", true);
        }

        public function openCatalogPage(_arg_1:String, _arg_2:String=null):void
        {
            cancelFurniInMover();
            toggleCatalog(((_arg_2 == null) ? "NORMAL" : _arg_2), true, false);
            if ((((!(_SafeStr_527)) || (_catalogNavigators == null)) || (!(currentCatalogNavigator.initialized))))
            {
                _SafeStr_522.requestByName = _arg_1;
                return;
            };
            currentCatalogNavigator.openPage(_arg_1);
        }

        public function openRoomAdCatalogPageInExtendedMode(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Date, _arg_6:int):void
        {
            var _local_8:int = _SafeStr_532;
            _roomAdPurchaseData = new RoomAdPurchaseData();
            _roomAdPurchaseData.name = _arg_2;
            _roomAdPurchaseData.extended = true;
            _roomAdPurchaseData.extendedFlatId = _roomEngine.activeRoomId;
            _roomAdPurchaseData.description = _arg_3;
            _roomAdPurchaseData.flatId = _roomEngine.activeRoomId;
            _roomAdPurchaseData.roomName = _arg_4;
            _roomAdPurchaseData.expirationTime = _arg_5;
            _roomAdPurchaseData.categoryId = _arg_6;
            openCatalogPage(_arg_1);
            var _local_7:ICatalogNode = currentCatalogNavigator.getNodeByName(_arg_1);
            if (((!(_local_7 == null)) && (_local_7.pageId == _local_8)))
            {
                getRoomAdsPurchaseInfo();
            };
        }

        public function openCatalogPageByOfferId(_arg_1:int, _arg_2:String):void
        {
            openCatalogPageById(-12345678, _arg_1, _arg_2);
        }

        public function openCatalogPageById(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            if ((((_SafeStr_527) && (!(_catalogNavigators == null))) && (getCatalogNavigator(_arg_3).initialized)))
            {
                toggleCatalog(_arg_3, true, false);
                _SafeStr_528.setForceRefresh();
                currentCatalogNavigator.openPageById(_arg_1, _arg_2);
            }
            else
            {
                toggleCatalog(_arg_3);
                _SafeStr_522.requestById = _arg_1;
                _SafeStr_522.requestedOfferId = _arg_2;
            };
        }

        public function openInventoryCategory(_arg_1:String):void
        {
            if (_inventory == null)
            {
                return;
            };
            _inventory.toggleInventoryPage(_arg_1);
        }

        public function openCreditsHabblet():void
        {
            HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
        }

        public function get privateRoomSessionActive():Boolean
        {
            return (_privateRoomSessionActive);
        }

        public function get tradingActive():Boolean
        {
            if (_inventory == null)
            {
                return (false);
            };
            return (_inventory.tradingActive);
        }

        public function getProductData(_arg_1:String):IProductData
        {
            return (_sessionDataManager.getProductData(_arg_1));
        }

        public function getFurnitureData(_arg_1:int, _arg_2:String):IFurnitureData
        {
            var _local_3:IFurnitureData;
            if (_arg_2 == "s")
            {
                _local_3 = _sessionDataManager.getFloorItemData(_arg_1);
            };
            if (_arg_2 == "i")
            {
                _local_3 = _sessionDataManager.getWallItemData(_arg_1);
            };
            return (_local_3);
        }

        public function getFurnitureDataByName(_arg_1:String, _arg_2:String, _arg_3:int=0):IFurnitureData
        {
            var _local_4:IFurnitureData;
            if (_sessionDataManager == null)
            {
                return (null);
            };
            if (_arg_2 == "s")
            {
                _local_4 = _sessionDataManager.getFloorItemDataByName(_arg_1);
            };
            if (_arg_2 == "i")
            {
                _local_4 = _sessionDataManager.getWallItemDataByName(_arg_1);
            };
            return (_local_4);
        }

        public function getPurse():IPurse
        {
            return (_SafeStr_529);
        }

        public function getMarketPlace():IMarketPlace
        {
            return (_SafeStr_533);
        }

        public function getClubGiftController():ClubGiftController
        {
            return (_SafeStr_534);
        }

        public function getClubBuyController():ClubBuyController
        {
            return (_SafeStr_517);
        }

        public function getClubExtendController():ClubExtendController
        {
            return (_SafeStr_518);
        }

        public function getPublicMarketPlaceOffers(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):void
        {
            send(new GetMarketplaceOffersMessageComposer(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public function getRoomAdsPurchaseInfo():void
        {
            send(new GetRoomAdPurchaseInfoComposer());
        }

        public function sendRoomAdPurchaseInitiatedEvent():void
        {
            send(new RoomAdPurchaseInitiatedComposer());
        }

        public function getOwnMarketPlaceOffers():void
        {
            send(new GetMarketplaceOwnOffersMessageComposer());
        }

        public function buyMarketPlaceOffer(_arg_1:int):void
        {
            send(new BuyMarketplaceOfferMessageComposer(_arg_1));
        }

        public function redeemSoldMarketPlaceOffers():void
        {
            send(new RedeemMarketplaceOfferCreditsMessageComposer());
        }

        public function redeemExpiredMarketPlaceOffer(_arg_1:int):void
        {
            send(new CancelMarketplaceOfferMessageComposer(_arg_1));
        }

        public function getMarketplaceItemStats(_arg_1:int, _arg_2:int):void
        {
            if (!_communication)
            {
                return;
            };
            send(new GetMarketplaceItemStatsComposer(_arg_1, _arg_2));
        }

        public function getGroupMembershipsController():GuildMembershipsController
        {
            return (_SafeStr_521);
        }

        public function getPixelEffectIcon(_arg_1:int):BitmapData
        {
            var _local_2:BitmapDataAsset = ((_inventory as Component).assets.getAssetByName((("fx_icon_" + _arg_1) + "_png")) as BitmapDataAsset);
            if (((!(_local_2 == null)) && (!(_local_2.content == null))))
            {
                return ((_local_2.content as BitmapData).clone());
            };
            return (new BitmapData(1, 1, true, 0xFFFFFF));
        }

        public function getSubscriptionProductIcon(_arg_1:int):BitmapData
        {
            var _local_2:BitmapDataAsset = (assets.getAssetByName("icon_hc") as BitmapDataAsset);
            if (_local_2 != null)
            {
                return ((_local_2.content as BitmapData).clone());
            };
            return (new BitmapData(1, 1, true, 0xFFFFFF));
        }

        public function getSellablePetPalettes(_arg_1:String):Array
        {
            var _local_2:Array = _SafeStr_519.getValue(_arg_1);
            if (_local_2 != null)
            {
                return (_local_2.slice());
            };
            send(new GetSellablePetPalettesComposer(_arg_1));
            return (null);
        }

        private function updatePurse():void
        {
            var _local_4:String;
            if (_mainContainer == null)
            {
                return;
            };
            _localization.registerParameter("catalog.purse.creditbalance", "balance", String(_SafeStr_529.credits));
            _localization.registerParameter("catalog.purse.pixelbalance", "balance", String(_SafeStr_529.getActivityPointsForType(0)));
            var _local_3:uint = 11;
            if (!_SafeStr_529.hasClubLeft)
            {
                _local_4 = "catalog.purse.club.join";
            }
            else
            {
                if (_SafeStr_529.isVIP)
                {
                    _local_4 = "catalog.purse.vipdays";
                    _local_3 = 12;
                }
                else
                {
                    _local_4 = "catalog.purse.clubdays";
                };
                _localization.registerParameter(_local_4, "days", String(_SafeStr_529.clubDays));
                _localization.registerParameter(_local_4, "months", String(_SafeStr_529.clubPeriods));
            };
            var _local_2:IIconWindow = (_mainContainer.findChildByName("clubIcon") as IIconWindow);
            if (_local_2)
            {
                _local_2.style = _local_3;
            };
            var _local_1:ITextWindow = (_mainContainer.findChildByName("clubText") as ITextWindow);
            if (_local_1)
            {
                _local_1.caption = _localization.getLocalization(_local_4);
            };
        }

        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type != "HTE_TOOLBAR_CLICK")
            {
                return;
            };
            switch (_arg_1.iconId)
            {
                case "HTIE_ICON_CATALOGUE":
                    toggleCatalog("NORMAL");
                    return;
                case "HTIE_ICON_BUILDER":
                    toggleCatalog("BUILDERS_CLUB");
                    return;
            };
        }

        private function setElementColour(_arg_1:String, _arg_2:int):void
        {
            if (_mainContainer == null)
            {
                return;
            };
            var _local_3:IWindow = _mainContainer.findChildByName(_arg_1);
            if (_local_3 != null)
            {
                _local_3.color = _arg_2;
            };
        }

        public function get buildersClubEnabled():Boolean
        {
            return (getBoolean("builders.club.enabled"));
        }

        public function toggleCatalog(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=true):void
        {
            var _local_4:ITextFieldWindow;
            if (((!(_sessionDataManager.hasSecurity(5))) && (!(buildersClubEnabled))))
            {
                _arg_1 = "NORMAL";
            };
            var _local_5:Boolean = (!(_arg_1 == _catalogType));
            _catalogType = _arg_1;
            cancelFurniInMover();
            if (_mainContainer == null)
            {
                if (init() == false)
                {
                    return;
                };
            };
            if (((currentCatalogNavigator == null) || (!(currentCatalogNavigator.initialized))))
            {
                refreshCatalogIndex(_catalogType);
            };
            if ((((!(mainWindowVisible())) || (_arg_2)) || (_local_5)))
            {
                if (_SafeStr_535)
                {
                    _SafeStr_535 = false;
                    events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_HIDE"));
                    markNewAdditionPageOpened();
                };
                showMainWindow();
            }
            else
            {
                if (!WindowToggle.isHiddenByOtherWindows(_mainContainer))
                {
                    hideMainWindow();
                };
            };
            if (mainWindowVisible())
            {
                if (_mainContainer != null)
                {
                    _mainContainer.activate();
                    _local_4 = (_mainContainer.findChildByName("search.input") as ITextFieldWindow);
                    if (_local_4)
                    {
                        _local_4.focus();
                        _local_4.setSelection(0, _local_4.text.length);
                    };
                }
                else
                {
                    Logger.log("[Catalog] No main container!");
                };
                HabboTracking.getInstance().trackGoogle("catalogue", "open");
            };
            if (_mainContainer != null)
            {
                _mainContainer.color = ((_arg_1 == "NORMAL") ? 4296112 : 16758076);
                _mainContainer.caption = ((_arg_1 == "NORMAL") ? "${catalog.title}" : "${builder.catalog.title}");
                _mainContainer.findChildByName("catalog.header.background.border").color = ((_arg_1 == "NORMAL") ? 4281819765 : 4283320388);
                _mainContainer.findChildByName("catalog.header.background.body").color = ((_arg_1 == "NORMAL") ? 4279123794 : 4281149220);
                _mainContainer.findChildByName("catalog.mode.header").visible = (_arg_1 == "NORMAL");
                _mainContainer.findChildByName("builder.mode.header").visible = (_arg_1 == "BUILDERS_CLUB");
                refreshBuilderStatus();
            };
            if (mainWindowVisible())
            {
                events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_OPEN"));
            }
            else
            {
                events.dispatchEvent(new Event("HABBO_CATALOG_TRACKING_EVENT_CLOSE"));
            };
            if (((_local_5) && (!(currentCatalogNavigator == null))))
            {
                if (_arg_3)
                {
                    currentCatalogNavigator.deactivateCurrentNode();
                    currentCatalogNavigator.loadFrontPage();
                };
                currentCatalogNavigator.showIndex();
                if (_SafeStr_528 != null)
                {
                    _SafeStr_528.setForceRefresh();
                };
            };
        }

        private function getCurrentLayoutCode():String
        {
            if (_SafeStr_528 == null)
            {
                return ("");
            };
            return (_SafeStr_528.getCurrentLayoutCode());
        }

        private function refreshCatalogIndex(_arg_1:String):void
        {
            send(new GetCatalogIndexComposer(_arg_1));
        }

        private function markNewAdditionPageOpened():void
        {
            send(new MarkCatalogNewAdditionsPageOpenedComposer());
        }

        private function createCatalogNavigators():void
        {
            _catalogNavigators = new Dictionary();
            _catalogNavigators["NORMAL"] = new CatalogNavigator(this, _mainContainer, "NORMAL");
            _catalogNavigators["BUILDERS_CLUB"] = new CatalogNavigator(this, _mainContainer, "BUILDERS_CLUB");
            var _local_1:BitmapDataAsset = (assets.getAssetByName("purse_coins_small") as BitmapDataAsset);
            setElementImage("creditsIcon", (_local_1.content as BitmapData));
            var _local_3:BitmapDataAsset = (assets.getAssetByName("purse_pixels_small") as BitmapDataAsset);
            setElementImage("pixelsIcon", (_local_3.content as BitmapData));
            var _local_2:BitmapDataAsset = (assets.getAssetByName("purse_club_small") as BitmapDataAsset);
            setElementImage("clubIcon", (_local_2.content as BitmapData));
        }

        private function createCatalogViewer():void
        {
            var _local_1:IWindowContainer = (_mainContainer.findChildByName("layoutContainer") as IWindowContainer);
            _SafeStr_528 = new CatalogViewer(this, _local_1);
        }

        private function createMainWindow():void
        {
            var _local_4:String;
            var _local_2:IWindow;
            if (useNonTabbedCatalog())
            {
                _local_4 = "catalog_ubuntu";
            }
            else
            {
                _local_4 = "catalog_ubuntu_with_tabs";
            };
            var _local_5:XmlAsset = (assets.getAssetByName(_local_4) as XmlAsset);
            _mainContainer = (_windowManager.buildFromXML((_local_5.content as XML), 1) as IWindowContainer);
            _mainContainer.tags.push("habbo_catalog");
            _mainContainer.position = DEFAULT_VIEW_LOCATION_LARGE;
            hideMainWindow();
            var _local_3:IWindow = _mainContainer.findChildByName("titlebar_close_button");
            if (_local_3 == null)
            {
                _local_3 = _mainContainer.findChildByTag("close");
            };
            if (_local_3 != null)
            {
                _local_3.procedure = onWindowClose;
            };
            var _local_1:ITextFieldWindow = (_mainContainer.findChildByName("search.input") as ITextFieldWindow);
            if (_local_1)
            {
                _local_1.addEventListener("WKE_KEY_DOWN", onSearchInputEvent);
                _local_1.addEventListener("WKE_KEY_UP", onSearchInputEvent);
                _local_1.setSelection(0, _local_1.text.length);
                _local_1.focus();
                _local_2 = _mainContainer.findChildByName("clear_search_button");
                if (_local_2)
                {
                    _local_2.addEventListener("WME_CLICK", onClearSearch);
                };
            };
        }

        public function set isBusy(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (_mainContainer)
            {
                _mainContainer.caption = ((_arg_1) ? "${generic.loading}" : "${catalog.title}");
                _local_2 = _mainContainer.findChildByName("search_waiting_for_results_mask");
                if (_local_2)
                {
                    _local_2.visible = _arg_1;
                };
            };
        }

        private function onSelectSearch(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextFieldWindow = (_arg_1.target as ITextFieldWindow);
            if (_local_2)
            {
                _local_2.setSelection(0, _local_2.text.length);
                _local_2.focus();
            };
        }

        private function onClearSearch(_arg_1:WindowMouseEvent=null):void
        {
            var _local_2:ITextFieldWindow = (_mainContainer.findChildByName("search.input") as ITextFieldWindow);
            _local_2.caption = "";
            _local_2.setSelection(0, _local_2.text.length);
            _local_2.focus();
            var _local_3:IStaticBitmapWrapperWindow = (_mainContainer.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow);
            _local_3.assetUri = "common_small_pen";
            if (_SafeStr_528.previousPageId > 0)
            {
                currentCatalogNavigator.openPageById(_SafeStr_528.previousPageId, -1);
            };
            _mainContainer.findChildByName("search.helper").visible = true;
        }

        private function onSearchInputEvent(_arg_1:WindowKeyboardEvent):void
        {
            if (_arg_1.type == "WKE_KEY_DOWN")
            {
                if (_SafeStr_536)
                {
                    _SafeStr_536.stop();
                };
                return;
            };
            if (_SafeStr_536 == null)
            {
                _SafeStr_536 = new Timer(50, 1);
            };
            if (_arg_1.target.caption.length >= 3)
            {
                _SafeStr_536.addEventListener("timer", onKeyUpSearchTimer);
                _SafeStr_536.start();
            };
            var _local_2:IWindow = _mainContainer.findChildByName("search.helper");
            _local_2.visible = (_arg_1.target.caption.length == 0);
            var _local_3:IStaticBitmapWrapperWindow = (_mainContainer.findChildByName("search.clear.icon") as IStaticBitmapWrapperWindow);
            _local_3.assetUri = ((_arg_1.target.caption.length > 0) ? "icons_close" : "common_small_pen");
            if (_arg_1.target.caption.length == 0)
            {
                onClearSearch();
            }
            else
            {
                if (_arg_1.keyCode == 13)
                {
                    performSearch(_arg_1.target.caption);
                };
            };
        }

        private function onKeyUpSearchTimer(_arg_1:TimerEvent):void
        {
            var _local_2:ITextFieldWindow = (_mainContainer.findChildByName("search.input") as ITextFieldWindow);
            performSearch(_local_2.caption);
        }

        private function performSearch(_arg_1:String):void
        {
            var _local_3:String;
            var _local_8:Vector.<ICatalogNode> = undefined;
            var _local_5:Vector.<ICatalogNode> = undefined;
            if (_SafeStr_536)
            {
                _SafeStr_536.stop();
            };
            if ((((_SafeStr_537 == null) || (_arg_1 == null)) || (_arg_1.length == 0)))
            {
                return;
            };
            var _local_2:Array = [];
            var _local_4:Vector.<IFurnitureData> = new Vector.<IFurnitureData>(0);
            var _local_7:String = _arg_1.toLocaleLowerCase().replace(" ", "");
            for each (var _local_6:IFurnitureData in _SafeStr_537)
            {
                if (!((_catalogType == "BUILDERS_CLUB") && (!(_local_6.availableForBuildersClub))))
                {
                    if (!((_catalogType == "NORMAL") && (_local_6.excludedFromDynamic)))
                    {
                        _local_3 = [_local_6.localizedName, _local_6.description, _local_6.className].join(" ");
                        _local_3 = _local_3.replace(/ /gi, "");
                        if ((((_catalogType == "BUILDERS_CLUB") && (_local_6.purchaseOfferId == -1)) && (_local_6.rentOfferId == -1)))
                        {
                            if (((!(_local_6.furniLine == "")) && (_local_2.indexOf(_local_6.furniLine) < 0)))
                            {
                                if (_local_3.toLocaleLowerCase().indexOf(_local_7) >= 0)
                                {
                                    _local_2.push(_local_6.furniLine);
                                };
                            };
                        }
                        else
                        {
                            _local_8 = currentCatalogNavigator.getNodesByOfferId(_local_6.purchaseOfferId, true);
                            _local_5 = currentCatalogNavigator.getNodesByOfferId(_local_6.rentOfferId, true);
                            if (((!(_local_8 == null)) || ((_catalogType == "NORMAL") && (!(_local_5 == null)))))
                            {
                                if (_local_3.toLocaleLowerCase().indexOf(_local_7) >= 0)
                                {
                                    _local_4.push(_local_6);
                                    if (_local_4.length >= 200) break;
                                };
                            };
                        };
                    };
                };
            };
            localization.registerParameter("catalog.search.results", "count", _local_4.length.toString());
            localization.registerParameter("catalog.search.results", "needle", _arg_1);
            _mainContainer.findChildByName("catalog.header.title").caption = "${catalog.search.header}";
            currentCatalogNavigator.deactivateCurrentNode();
            _SafeStr_528.showSearchResults(_local_4);
            currentCatalogNavigator.filter(_local_7, _local_2);
        }

        public function furniDataReady():void
        {
            _SafeStr_537 = _sessionDataManager.getFurniData(this);
            _SafeStr_1655 = null;
        }

        private function onRoomSessionEvent(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type)
            {
                case "RSE_STARTED":
                    _privateRoomSessionActive = _arg_1.session.isPrivateRoom;
                    _roomSession = _arg_1.session;
                    break;
                case "RSE_ENDED":
                    _privateRoomSessionActive = false;
                    _roomSession = null;
            };
            if (currentPage != null)
            {
                currentPage.dispatchWidgetEvent(new CatalogWidgetRoomChangedEvent());
            };
        }

        private function createMarketPlace():void
        {
            if (_SafeStr_533 == null)
            {
                _SafeStr_533 = new MarketPlaceLogic(this, _windowManager, _roomEngine);
            };
        }

        private function createClubGiftController():void
        {
            if (_SafeStr_534 == null)
            {
                _SafeStr_534 = new ClubGiftController(this);
            };
        }

        private function createClubBuyController():void
        {
            if (_SafeStr_517 == null)
            {
                _SafeStr_517 = new ClubBuyController(this, connection);
            };
        }

        private function createClubExtendController():void
        {
            if (_SafeStr_518 == null)
            {
                _SafeStr_518 = new ClubExtendController(this);
            };
        }

        private function createGroupMembershipsController():void
        {
            if (_SafeStr_521 == null)
            {
                _SafeStr_521 = new GuildMembershipsController(this);
            };
        }

        private function getGiftWrappingConfiguration():void
        {
            send(new _SafeStr_48());
        }

        public function getHabboClubOffers(_arg_1:int):void
        {
            send(new GetClubOffersMessageComposer(_arg_1));
        }

        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            hideMainWindow();
            if (_SafeStr_528 != null)
            {
                _SafeStr_528.catalogWindowClosed();
            };
        }

        private function onCatalogIndex(_arg_1:CatalogIndexMessageEvent):void
        {
            var _local_2:ICatalogNavigator = getCatalogNavigator(_arg_1.catalogType);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_535 = _arg_1.newAdditionsAvailable;
            _local_2.buildCatalogIndex(_arg_1.root);
            if (_arg_1.catalogType == _catalogType)
            {
                _local_2.showIndex();
            };
            switch (_SafeStr_522.requestType)
            {
                case 0:
                    if (((((_SafeStr_535) && (_SafeStr_538)) && (!(newAdditionsPageOpenDisabled))) && (_arg_1.catalogType == "NORMAL")))
                    {
                        events.dispatchEvent(new CatalogEvent("CATALOG_NEW_ITEMS_SHOW"));
                        openCatalogPage("new_additions");
                    }
                    else
                    {
                        _local_2.loadFrontPage();
                    };
                    return;
                case 1:
                    _local_2.openPageById(_SafeStr_522.requestId, _SafeStr_522.requestedOfferId);
                    _SafeStr_522.resetRequest();
                    return;
                case 2:
                    _local_2.openPage(_SafeStr_522.requestName);
                    _SafeStr_522.resetRequest();
                default:
            };
        }

        private function onCatalogPage(_arg_1:CatalogPageMessageEvent):void
        {
            var _local_10:Vector.<IProduct> = undefined;
            var _local_11:IProductData;
            var _local_8:IFurnitureData;
            var _local_12:Offer;
            var _local_13:CatalogPageMessageParser = _arg_1.getParser();
            if (_local_13.catalogType != _catalogType)
            {
                return;
            };
            var _local_9:int = _local_13.pageId;
            var _local_4:String = _local_13.layoutCode;
            var _local_5:Array = _local_13.localization.images.concat();
            var _local_14:Array = _local_13.localization.texts.concat();
            var _local_2:IPageLocalization = new PageLocalization(_local_5, _local_14);
            var _local_15:int = _local_13.offerId;
            var _local_6:Boolean = _local_13.acceptSeasonCurrencyAsCredits;
            var _local_3:Vector.<IPurchasableOffer> = new Vector.<IPurchasableOffer>(0);
            for each (var _local_16:CatalogPageMessageOfferData in _local_13.offers)
            {
                _local_10 = new Vector.<IProduct>(0);
                _local_11 = getProductData(_local_16.localizationId);
                for each (var _local_7:CatalogPageMessageProductData in _local_16.products)
                {
                    _local_8 = getFurnitureData(_local_7.furniClassId, _local_7.productType);
                    _local_10.push(new Product(_local_7.productType, _local_7.furniClassId, _local_7.extraParam, _local_7.productCount, _local_11, _local_8, this, _local_7.uniqueLimitedItem, _local_7.uniqueLimitedItemSeriesSize, _local_7.uniqueLimitedItemsLeft));
                };
                if (!((_local_10.length == 0) && (!(HabboCatalogUtils.buildersClub(_local_16.localizationId)))))
                {
                    _local_12 = new Offer(_local_16.offerId, _local_16.localizationId, _local_16.isRent, _local_16.priceInCredits, _local_16.priceInActivityPoints, _local_16.activityPointType, _local_16.giftable, _local_16.clubLevel, _local_10, _local_16.bundlePurchaseAllowed, this);
                    if (((!(_local_12.productContainer == null)) && (isOfferCompatibleWithCurrentMode(_local_12))))
                    {
                        _local_3.push(_local_12);
                    }
                    else
                    {
                        _local_12.dispose();
                    };
                };
            };
            if (((!(_local_13.frontPageItems == null)) && (_local_13.frontPageItems.length > 0)))
            {
                _frontPageItems = _local_13.frontPageItems;
            };
            if (((!(_SafeStr_528 == null)) && (_SafeStr_532 == _local_9)))
            {
                _SafeStr_528.showCatalogPage(_local_9, _local_4, _local_2, _local_3, _local_15, _local_6);
            };
            isBusy = false;
        }

        private function isOfferCompatibleWithCurrentMode(_arg_1:Offer):Boolean
        {
            return ((_catalogType == "NORMAL") || ((!(_arg_1.pricingModel == "pricing_model_bundle")) && (!(_arg_1.pricingModel == "pricing_model_multi"))));
        }

        private function onCatalogPublished(_arg_1:IMessageEvent):void
        {
            var _local_2:Boolean = mainWindowVisible();
            reset();
            if (_local_2)
            {
                _windowManager.alert("${catalog.alert.published.title}", "${catalog.alert.published.description}", 0, alertDialogEventProcessor);
            };
        }

        private function onPurchaseError(_arg_1:IMessageEvent):void
        {
            var _local_3:PurchaseErrorMessageEvent = (_arg_1 as PurchaseErrorMessageEvent);
            var _local_2:PurchaseErrorMessageParser = _local_3.getParser();
            var _local_4:int = _local_2.errorCode;
            var _local_5:String = ((_local_4 > 0) ? (("${catalog.alert.purchaseerror.description." + _local_4) + "}") : "${catalog.alert.purchaseerror.description}");
            _windowManager.alert("${catalog.alert.purchaseerror.title}", _local_5, 0, alertDialogEventProcessor);
            if (_SafeStr_516 != null)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
        }

        private function onPurchaseNotAllowed(_arg_1:IMessageEvent):void
        {
            var _local_2:PurchaseNotAllowedMessageEvent = (_arg_1 as PurchaseNotAllowedMessageEvent);
            var _local_3:PurchaseNotAllowedMessageParser = _local_2.getParser();
            var _local_4:int = _local_3.errorCode;
            var _local_5:String = "";
            switch (_local_4)
            {
                case 1:
                    _local_5 = "${catalog.alert.purchasenotallowed.hc.description}";
                    break;
                default:
                    _local_5 = "${catalog.alert.purchasenotallowed.unknown.description}";
            };
            _windowManager.alert("${catalog.alert.purchasenotallowed.title}", _local_5, 0, alertDialogEventProcessor);
        }

        private function onPurchaseOK(_arg_1:IMessageEvent):void
        {
            var _local_6:IBitmapWrapperWindow;
            var _local_2:BitmapData;
            var _local_7:Point;
            var _local_5:String;
            var _local_3:PurchaseOKMessageEvent = (_arg_1 as PurchaseOKMessageEvent);
            var _local_4:PurchaseOKMessageParser = _local_3.getParser();
            events.dispatchEvent(new CatalogFurniPurchaseEvent(_local_4.offer.localizationId));
            if (_SafeStr_516 != null)
            {
                if (((!(_SafeStr_539)) && (!(_SafeStr_516.isGiftPurchase()))))
                {
                    _local_6 = _SafeStr_516.getIconWrapper();
                    if (_local_6)
                    {
                        _local_2 = _local_6.bitmap;
                        if (_local_2)
                        {
                            _local_7 = new Point();
                            _local_6.getGlobalPosition(_local_7);
                            _local_5 = "HTIE_ICON_INVENTORY";
                            if (_SafeStr_516.productType == "e")
                            {
                                _local_5 = "HTIE_ICON_MEMENU";
                            };
                            _toolbar.createTransitionToIcon(_local_5, _local_2.clone(), _local_7.x, _local_7.y);
                        };
                    };
                };
                _SafeStr_516.dispose();
            };
            _SafeStr_516 = null;
        }

        private function onGiftReceiverNotFound(_arg_1:GiftReceiverNotFoundEvent):void
        {
            if (_SafeStr_516 != null)
            {
                _SafeStr_516.receiverNotFound();
            };
        }

        private function onNotEnoughBalance(_arg_1:IMessageEvent):void
        {
            var _local_3:NotEnoughBalanceMessageEvent = (_arg_1 as NotEnoughBalanceMessageEvent);
            var _local_2:NotEnoughBalanceMessageParser = _local_3.getParser();
            if (_local_2.notEnoughCredits)
            {
                showNotEnoughCreditsAlert();
            }
            else
            {
                if (_local_2.notEnoughActivityPoints)
                {
                    showNotEnoughActivityPointsAlert(_local_2.activityPointType);
                };
            };
            if (_SafeStr_516 != null)
            {
                _SafeStr_516.notEnoughCredits();
            };
        }

        public function setLeftPaneVisibility(_arg_1:Boolean):void
        {
            if (!_mainContainer)
            {
                return;
            };
            var _local_2:IWindow = _mainContainer.findChildByName("navigationContainer");
            if (_local_2)
            {
                _local_2.visible = _arg_1;
            };
            _local_2 = _mainContainer.findChildByName("searchContainer");
            if (_local_2)
            {
                _local_2.visible = _arg_1;
            };
        }

        public function showNotEnoughCreditsAlert():void
        {
            if (!_windowManager)
            {
                return;
            };
            _windowManager.confirm("${catalog.alert.notenough.title}", "${catalog.alert.notenough.credits.description}", 0, noCreditsConfirmDialogEventProcessor);
        }

        public function showNotEnoughActivityPointsAlert(_arg_1:int):void
        {
            var _local_2:String = ("catalog.alert.notenough.activitypoints.title." + _arg_1);
            var _local_3:String = ("catalog.alert.notenough.activitypoints.description." + _arg_1);
            if (_arg_1 == 0)
            {
                _windowManager.confirm(localization.getLocalization(_local_2), localization.getLocalization(_local_3), 0, noDucketsConfirmDialogEventProcessor);
            }
            else
            {
                _windowManager.alert(localization.getLocalization(_local_2), localization.getLocalization(_local_3), 0, alertDialogEventProcessor);
            };
        }

        private function onVoucherRedeemOk(_arg_1:VoucherRedeemOkMessageEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:String = "${catalog.alert.voucherredeem.ok.description}";
            if (_arg_1.productName != "")
            {
                _local_2 = "catalog.alert.voucherredeem.ok.description.furni";
                _localization.registerParameter(_local_2, "productName", _arg_1.productName);
                _localization.registerParameter(_local_2, "productDescription", _arg_1.productDescription);
                _local_2 = (("${" + _local_2) + "}");
            };
            _windowManager.alert("${catalog.alert.voucherredeem.ok.title}", _local_2, 0, alertDialogEventProcessor);
        }

        private function onVoucherRedeemError(_arg_1:VoucherRedeemErrorMessageEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            var _local_2:String = "${catalog.alert.voucherredeem.error.title}";
            var _local_3:String = (("${catalog.alert.voucherredeem.error.description." + _arg_1.errorCode) + "}");
            _windowManager.alert(_local_2, _local_3, 0, alertDialogEventProcessor);
        }

        private function onApproveNameResult(_arg_1:ApproveNameMessageEvent):void
        {
            if (((_arg_1 == null) || (_SafeStr_528 == null)))
            {
                return;
            };
            var _local_2:ApproveNameMessageParser = _arg_1.getParser();
            _SafeStr_528.dispatchWidgetEvent(new CatalogWidgetApproveNameResultEvent(_local_2.result, _local_2.nameValidationInfo));
        }

        private function onCreditBalance(_arg_1:IMessageEvent):void
        {
            var _local_3:CreditBalanceEvent = (_arg_1 as CreditBalanceEvent);
            var _local_2:CreditBalanceParser = _local_3.getParser();
            _SafeStr_529.credits = _local_2.balance;
            updatePurse();
            if (((!(_SafeStr_540)) && (!(_soundManager == null))))
            {
                _soundManager.playSound("HBST_purchase");
            };
            _SafeStr_540 = false;
            events.dispatchEvent(new PurseEvent("catalog_purse_credit_balance", _SafeStr_529.credits, 0));
            events.dispatchEvent(new PurseUpdateEvent());
        }

        private function onActivityPointNotification(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboActivityPointNotificationMessageEvent = (_arg_1 as HabboActivityPointNotificationMessageEvent);
            _SafeStr_529.activityPoints[_local_2.type] = _local_2.amount;
            updatePurse();
            if (((!(_soundManager == null)) && (_local_2.type == 0)))
            {
                _soundManager.playSound("HBST_pixels");
            };
            events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance", _local_2.amount, _local_2.type));
            events.dispatchEvent(new PurseUpdateEvent());
        }

        private function onActivityPoints(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_3:ActivityPointsMessageEvent = (_arg_1 as ActivityPointsMessageEvent);
            _SafeStr_529.activityPoints = _local_3.points;
            updatePurse();
            for (var _local_2:String in _local_3.points)
            {
                _local_4 = int(_local_2);
                events.dispatchEvent(new PurseEvent("catalog_purse_activity_point_balance", _local_3.points[_local_4], _local_4));
            };
            events.dispatchEvent(new PurseUpdateEvent());
        }

        private function onSubscriptionInfo(_arg_1:IMessageEvent):void
        {
            var _local_3:Boolean;
            var _local_2:ScrSendUserInfoMessageParser = (_arg_1 as ScrSendUserInfoEvent).getParser();
            _SafeStr_529.clubDays = Math.max(0, _local_2.daysToPeriodEnd);
            _SafeStr_529.clubPeriods = Math.max(0, _local_2.periodsSubscribedAhead);
            _SafeStr_529.isVIP = _local_2.isVIP;
            _SafeStr_529.pastClubDays = _local_2.pastClubDays;
            _SafeStr_529.pastVipDays = _local_2.pastVipDays;
            _SafeStr_529.isExpiring = ((_local_2.responseType == 3) ? true : false);
            _SafeStr_529.minutesUntilExpiration = _local_2.minutesUntilExpiration;
            _SafeStr_529.minutesSinceLastModified = _local_2.minutesSinceLastModified;
            if (ExternalInterface.available)
            {
                if (((_local_2.productName == "habbo_club") || (_local_2.productName == "club_habbo")))
                {
                    _local_3 = ((_local_2.isVIP) && (_local_2.minutesUntilExpiration > 0));
                    ExternalInterface.call("FlashExternalInterface.subscriptionUpdated", _local_3);
                };
            };
            updatePurse();
            if (_local_2.responseType == 2)
            {
                reset();
                if (_SafeStr_541 != null)
                {
                    openCatalogPage(_SafeStr_541);
                    _SafeStr_541 = null;
                };
            };
        }

        private function onClubGiftInfo(_arg_1:ClubGiftInfoEvent):void
        {
            if (((!(_arg_1)) || (!(_SafeStr_534))))
            {
                return;
            };
            var _local_2:ClubGiftInfoParser = _arg_1.getParser();
            if (!_local_2)
            {
                return;
            };
            _SafeStr_534.setInfo(_local_2.daysUntilNextGift, _local_2.giftsAvailable, _local_2.offers, _local_2.giftData);
        }

        private function onMarketPlaceOffers(_arg_1:IMessageEvent):void
        {
            if (_SafeStr_533 != null)
            {
                _SafeStr_533.onOffers(_arg_1);
            };
        }

        private function onMarketPlaceOwnOffers(_arg_1:IMessageEvent):void
        {
            if (_SafeStr_533 != null)
            {
                _SafeStr_533.onOwnOffers(_arg_1);
            };
        }

        private function onMarketPlaceBuyResult(_arg_1:IMessageEvent):void
        {
            if (_SafeStr_533 != null)
            {
                _SafeStr_533.onBuyResult(_arg_1);
            };
        }

        private function onMarketPlaceCancelResult(_arg_1:IMessageEvent):void
        {
            if (_SafeStr_533 != null)
            {
                _SafeStr_533.onCancelResult(_arg_1);
            };
        }

        private function onGiftWrappingConfiguration(_arg_1:GiftWrappingConfigurationEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _giftWrappingConfiguration = new GiftWrappingConfiguration(_arg_1);
        }

        private function onMarketplaceItemStats(_arg_1:MarketplaceItemStatsEvent):void
        {
            if (((!(_arg_1)) || (!(_SafeStr_533))))
            {
                return;
            };
            var _local_2:MarketplaceItemStatsParser = _arg_1.getParser();
            if (!_local_2)
            {
                return;
            };
            var _local_3:MarketplaceItemStats = new MarketplaceItemStats();
            _local_3.averagePrice = _local_2.averagePrice;
            _local_3.offerCount = _local_2.offerCount;
            _local_3.historyLength = _local_2.historyLength;
            _local_3.dayOffsets = _local_2.dayOffsets;
            _local_3.averagePrices = _local_2.averagePrices;
            _local_3.soldAmounts = _local_2.soldAmounts;
            _local_3.furniCategoryId = _local_2.furniCategoryId;
            _local_3.furniTypeId = _local_2.furniTypeId;
            _SafeStr_533.itemStats = _local_3;
        }

        private function onMarketplaceConfiguration(_arg_1:MarketplaceConfigurationEvent):void
        {
            if (((!(_arg_1)) || (!(_SafeStr_533))))
            {
                return;
            };
            var _local_2:MarketplaceConfigurationParser = _arg_1.getParser();
            if (!_local_2)
            {
                return;
            };
            _SafeStr_533.averagePricePeriod = _local_2.averagePricePeriod;
        }

        private function onMarketplaceMakeOfferResult(_arg_1:MarketplaceMakeOfferResult):void
        {
            if (((!(_arg_1)) || (!(_SafeStr_533))))
            {
                return;
            };
            var _local_2:MarketplaceMakeOfferResultParser = _arg_1.getParser();
            if (!_local_2)
            {
                return;
            };
            if (_local_2.result == 1)
            {
                _SafeStr_533.refreshOffers();
            };
        }

        private function onHabboClubOffers(_arg_1:HabboClubOffersMessageEvent):void
        {
            var _local_2:HabboClubOffersMessageParser = _arg_1.getParser();
            if (((!(_SafeStr_517 == null)) && ((((_local_2.source == 0) || (_local_2.source == 1)) || (_local_2.source == 2)) || (_local_2.source == 6))))
            {
                _SafeStr_517.onOffers(_local_2);
            };
        }

        private function onHabboClubExtendOffer(_arg_1:HabboClubExtendOfferMessageEvent):void
        {
            if (!_SafeStr_527)
            {
                init();
            };
            if (_SafeStr_518)
            {
                _SafeStr_518.onOffer(_arg_1);
            };
        }

        private function onRoomExit(_arg_1:IMessageEvent):void
        {
        }

        private function onSellablePalettes(_arg_1:SellablePetPalettesMessageEvent):void
        {
            var _local_2:SellablePetPalettesParser = _arg_1.getParser();
            _SafeStr_519.remove(_local_2.productCode);
            var _local_3:Array = _local_2.sellablePalettes;
            if (_local_3 != null)
            {
                _SafeStr_519.add(_local_2.productCode, _local_3.slice());
                _SafeStr_528.dispatchWidgetEvent(new CatalogWidgetSellablePetPalettesEvent(_local_2.productCode, _local_3.slice()));
            };
        }

        private function setElementImage(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (_mainContainer.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 != null)
            {
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(0, 0));
            }
            else
            {
                Logger.log(("Could not find element: " + _arg_1));
            };
        }

        private function alertDialogEventProcessor(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            resetPlacedOfferData();
        }

        private function noCreditsConfirmDialogEventProcessor(_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
            resetPlacedOfferData();
            if (_arg_2.type == "WE_OK")
            {
                HabboWebTools.openWebPageAndMinimizeClient(getProperty("web.shop.relativeUrl"));
            };
        }

        private function noDucketsConfirmDialogEventProcessor(_arg_1:_SafeStr_126, _arg_2:WindowEvent):void
        {
            var _local_3:String;
            _arg_1.dispose();
            resetPlacedOfferData();
            if (_arg_2.type == "WE_OK")
            {
                _local_3 = getProperty("link.format.duckets");
                if (_local_3 != "")
                {
                    _windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, onExternalLink);
                    HabboWebTools.navigateToURL(_local_3, "habboMain");
                };
            };
        }

        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

        public function redeemVoucher(_arg_1:String):void
        {
            var _local_2:IMessageComposer = new RedeemVoucherMessageComposer(_arg_1);
            send(_local_2);
            _local_2.dispose();
            _local_2 = null;
        }

        public function productDataReady():void
        {
            _SafeStr_510 = true;
            events.dispatchEvent(new CatalogEvent("CATALOG_INITIALIZED"));
        }

        public function isDraggable(_arg_1:IPurchasableOffer):Boolean
        {
            return (((((((((getBoolean("catalog.drag_and_drop")) && (!(_roomSession == null))) && ((_SafeStr_528.currentPage == null) || (_SafeStr_528.currentPage.allowDragging))) && (((_catalogType == "NORMAL") && ((_roomSession.isRoomOwner) || ((_roomSession.isGuildRoom) && (_roomSession.roomControllerLevel >= 2)))) || ((_catalogType == "BUILDERS_CLUB") && (getBuilderFurniPlaceableStatus(_arg_1) == 0)))) && (!(_arg_1.pricingModel == "pricing_model_bundle"))) && (!(_arg_1.pricingModel == "pricing_model_multi"))) && (!(_arg_1.product == null))) && (!(_arg_1.product.productType == "e"))) && (!(_arg_1.product.productType == "h")));
        }

        public function getBuilderFurniPlaceableStatus(_arg_1:IPurchasableOffer):int
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:IRoomObject;
            var _local_2:IUserData;
            if (_arg_1 == null)
            {
                return (1);
            };
            if (((builderFurniCount < 0) || (builderFurniCount >= builderFurniLimit)))
            {
                return (2);
            };
            if (roomSession == null)
            {
                return (3);
            };
            if (!roomSession.isRoomOwner)
            {
                return (4);
            };
            if (((roomSession.isGuildRoom) && (!(getBoolean("builders.club.furniture.placement.group.room.enabled")))))
            {
                return (5);
            };
            if (builderSecondsLeft <= 0)
            {
                _local_3 = roomEngine.getRoomObjectCount(roomSession.roomId, 100);
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _local_5 = roomEngine.getRoomObjectWithIndex(roomSession.roomId, _local_4, 100);
                    _local_2 = roomSession.userDataManager.getUserDataByIndex(_local_5.getId());
                    if (((((!(_local_2 == null)) && (_local_2.type == 1)) && (!(_local_2.roomObjectId == roomSession.ownUserRoomId))) && (!(_local_2.isModerator))))
                    {
                        return (6);
                    };
                    _local_4++;
                };
            };
            return (0);
        }

        private function updateRoom(_arg_1:String, _arg_2:String):void
        {
            var _local_4:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_wall_type");
            var _local_5:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_floor_type");
            var _local_3:String = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_landscape_type");
            _local_4 = (((_local_4) && (_local_4.length > 0)) ? _local_4 : "101");
            _local_5 = (((_local_5) && (_local_5.length > 0)) ? _local_5 : "101");
            _local_3 = (((_local_3) && (_local_3.length > 0)) ? _local_3 : "1.1");
            switch (_arg_1)
            {
                case "floor":
                    _roomEngine.updateObjectRoom(_roomEngine.activeRoomId, _arg_2, _local_4, _local_3, true);
                    return;
                case "wallpaper":
                    _roomEngine.updateObjectRoom(_roomEngine.activeRoomId, _local_5, _arg_2, _local_3, true);
                    return;
                case "landscape":
                    _roomEngine.updateObjectRoom(_roomEngine.activeRoomId, _local_5, _local_4, _arg_2, true);
                    return;
                default:
                    _roomEngine.updateObjectRoom(_roomEngine.activeRoomId, _local_5, _local_4, _local_3, true);
                    return;
            };
        }

        public function requestSelectedItemToMover(_arg_1:IDragAndDropDoneReceiver, _arg_2:IPurchasableOffer, _arg_3:Boolean=false):void
        {
            var _local_6:int;
            if (!isDraggable(_arg_2))
            {
                return;
            };
            var _local_4:IProduct = _arg_2.product;
            switch (_local_4.productType)
            {
                case "s":
                    _local_6 = 10;
                    break;
                case "i":
                    _local_6 = 20;
            };
            var _local_5:Boolean = _roomEngine.initializeRoomObjectInsert("catalog", -(_arg_2.offerId), _local_6, _local_4.productClassId, ((_local_4.extraParam) ? _local_4.extraParam.toString() : null));
            if (_local_5)
            {
                _offerInFurniPlacing = _arg_2;
                _offerPlacingCallbackReceiver = _arg_1;
                hideMainWindow();
                _SafeStr_539 = true;
                _SafeStr_542 = _arg_3;
            };
        }

        private function onObjectSelected(_arg_1:RoomEngineObjectEvent):void
        {
            var _local_2:IUserData;
            if (_arg_1 == null)
            {
                return;
            };
            if (((buildersClubEnabled) && ((!(_SafeStr_527)) || (!(getCatalogNavigator("BUILDERS_CLUB").initialized)))))
            {
                init();
                refreshCatalogIndex("BUILDERS_CLUB");
            };
            if (((_arg_1.type == "REOE_SELECTED") && (_arg_1.category == 100)))
            {
                _local_2 = getUserDataForEvent(_arg_1);
                if (_local_2 != null)
                {
                    events.dispatchEvent(new CatalogUserEvent("CATALOG_USER_SELECTED", _local_2.webID, _local_2.name));
                };
            };
        }

        private function onFriendBarSelectionEvent(_arg_1:FriendBarSelectionEvent):void
        {
            var _local_3:int;
            var _local_2:String;
            var _local_4:IDragAndDropDoneReceiver;
            if (((_SafeStr_539) && (_arg_1.type == "FBVE_FRIEND_SELECTED")))
            {
                resetPlacedOfferData(true);
                if (((_offerInFurniPlacing == null) || (_offerInFurniPlacing.disposed)))
                {
                    resetObjectMover();
                    return;
                };
                _local_3 = _arg_1.friendId;
                _local_2 = _arg_1.friendName;
                _local_4 = _offerPlacingCallbackReceiver;
                if (_local_4 != null)
                {
                    _local_4.onDragAndDropDone(true, _local_2);
                };
                resetObjectMover(false);
                cancelFurniInMover();
            };
        }

        private function getUserDataForEvent(_arg_1:RoomEngineObjectEvent):IUserData
        {
            var _local_3:IRoomSession;
            var _local_2:IUserData;
            if (_roomSessionManager != null)
            {
                _local_3 = _roomSessionManager.getSession(_arg_1.roomId);
                if (_local_3 != null)
                {
                    _local_2 = _local_3.userDataManager.getUserDataByIndex(_arg_1.objectId);
                };
            };
            return (_local_2);
        }

        private function onObjectPlaceOnUser(_arg_1:RoomEngineObjectPlacedOnUserEvent):void
        {
            var _local_4:String;
            var _local_2:IUserData;
            var _local_3:IDragAndDropDoneReceiver;
            if (((_SafeStr_539) && (_arg_1.type == "REOE_PLACED_ON_USER")))
            {
                resetPlacedOfferData(true);
                if (((_offerInFurniPlacing == null) || (_offerInFurniPlacing.disposed)))
                {
                    resetObjectMover();
                    return;
                };
                _local_4 = null;
                _local_2 = getUserDataForEvent(_arg_1);
                if (_local_2 != null)
                {
                    _local_4 = _local_2.name;
                };
                _local_3 = _offerPlacingCallbackReceiver;
                if (_local_3 != null)
                {
                    _local_3.onDragAndDropDone(true, _local_4);
                };
                resetObjectMover(false);
                cancelFurniInMover();
            };
        }

        private function onObjectPlacedInRoom(_arg_1:RoomEngineObjectPlacedEvent):void
        {
            var _local_7:int;
            var _local_2:IProduct;
            var _local_5:Boolean;
            var _local_6:IDragAndDropDoneReceiver;
            var _local_4:IRoomObjectController;
            var _local_8:int;
            var _local_3:Vector.<ICatalogNode> = undefined;
            if (((_SafeStr_539) && (_arg_1.type == "REOE_PLACED")))
            {
                resetPlacedOfferData(true);
                if (((_offerInFurniPlacing == null) || (_offerInFurniPlacing.disposed)))
                {
                    resetObjectMover();
                    return;
                };
                _local_7 = _arg_1.category;
                _local_2 = _offerInFurniPlacing.product;
                _local_5 = false;
                if (_local_7 == 20)
                {
                    switch (_local_2.furnitureData.className)
                    {
                        case "floor":
                        case "wallpaper":
                        case "landscape":
                            _local_5 = ((_arg_1.placedOnFloor) || (_arg_1.placedOnWall));
                            break;
                        default:
                            _local_5 = _arg_1.placedInRoom;
                    };
                }
                else
                {
                    _local_5 = _arg_1.placedInRoom;
                };
                if (!_local_5)
                {
                    resetObjectMover();
                    return;
                };
                _SafeStr_543 = new PlacedObjectPurchaseData(_arg_1.roomId, _arg_1.objectId, _arg_1.category, _arg_1.wallLocation, _arg_1.x, _arg_1.y, _arg_1.direction, _offerInFurniPlacing);
                _local_6 = _offerPlacingCallbackReceiver;
                if (_local_6 != null)
                {
                    _local_6.onDragAndDropDone(true, null);
                };
                switch (_catalogType)
                {
                    case "NORMAL":
                        if (_local_7 == 10)
                        {
                            _roomEngine.addObjectFurniture(_arg_1.roomId, _arg_1.objectId, _local_2.productClassId, new Vector3d(_arg_1.x, _arg_1.y, _arg_1.z), new Vector3d(_arg_1.direction, 0, 0), 0, new LegacyStuffData());
                        }
                        else
                        {
                            if (_local_7 == 20)
                            {
                                switch (_local_2.furnitureData.className)
                                {
                                    case "floor":
                                    case "wallpaper":
                                    case "landscape":
                                        updateRoom(_local_2.furnitureData.className, _local_2.extraParam);
                                        break;
                                    default:
                                        _roomEngine.addObjectWallItem(_arg_1.roomId, _arg_1.objectId, _local_2.productClassId, new Vector3d(_arg_1.x, _arg_1.y, _arg_1.z), new Vector3d((_arg_1.direction * 45), 0, 0), 0, _arg_1.instanceData, 0);
                                };
                            };
                        };
                        _local_4 = (_roomEngine.getRoomObject(_arg_1.roomId, _arg_1.objectId, _arg_1.category) as IRoomObjectController);
                        if (_local_4)
                        {
                            _local_4.getModelController().setNumber("furniture_alpha_multiplier", 0.5);
                        };
                        return;
                    case "BUILDERS_CLUB":
                        _local_8 = _offerInFurniPlacing.page.pageId;
                        if (_local_8 == -12345678)
                        {
                            _local_3 = currentCatalogNavigator.getNodesByOfferId(_offerInFurniPlacing.offerId, true);
                            if (_local_3 != null)
                            {
                                _local_8 = _local_3[0].pageId;
                            };
                        };
                        switch (_local_7)
                        {
                            case 10:
                                send(new BuildersClubPlaceRoomItemMessageComposer(_local_8, _offerInFurniPlacing.offerId, _local_2.extraParam, _arg_1.x, _arg_1.y, _arg_1.direction));
                                break;
                            case 20:
                                send(new BuildersClubPlaceWallItemMessageComposer(_local_8, _offerInFurniPlacing.offerId, _local_2.extraParam, _arg_1.wallLocation));
                            default:
                        };
                        if (_SafeStr_542)
                        {
                            requestSelectedItemToMover(_local_6, _offerInFurniPlacing, true);
                        }
                        else
                        {
                            toggleBuilderCatalog();
                        };
                        return;
                };
            };
        }

        private function resetObjectMover(_arg_1:Boolean=true):void
        {
            if (((_arg_1) && (_SafeStr_539)))
            {
                showMainWindow();
            };
            _SafeStr_539 = false;
            _offerPlacingCallbackReceiver = null;
        }

        public function syncPlacedOfferWithPurchase(_arg_1:IPurchasableOffer):void
        {
            if (_SafeStr_543)
            {
                if (_SafeStr_543.offerId != _arg_1.offerId)
                {
                    resetPlacedOfferData();
                };
            };
        }

        public function resetPlacedOfferData(_arg_1:Boolean=false):void
        {
            if (!_arg_1)
            {
                resetObjectMover();
            };
            if (_SafeStr_543 != null)
            {
                if (_SafeStr_543.category == 10)
                {
                    _roomEngine.disposeObjectFurniture(_SafeStr_543.roomId, _SafeStr_543.objectId);
                }
                else
                {
                    if (_SafeStr_543.category == 20)
                    {
                        switch (_SafeStr_543.furniData.className)
                        {
                            case "floor":
                            case "wallpaper":
                            case "landscape":
                                updateRoom("reset", "");
                                break;
                            default:
                                _roomEngine.disposeObjectWallItem(_SafeStr_543.roomId, _SafeStr_543.objectId);
                        };
                    }
                    else
                    {
                        _roomEngine.deleteRoomObject(_SafeStr_543.objectId, _SafeStr_543.category);
                    };
                };
                _SafeStr_543.dispose();
                _SafeStr_543 = null;
            };
        }

        public function cancelFurniInMover():void
        {
            if (_offerInFurniPlacing != null)
            {
                _roomEngine.cancelRoomObjectInsert();
                _SafeStr_539 = false;
                _offerInFurniPlacing = null;
            };
        }

        private function onItemAddedToInventory(_arg_1:HabboInventoryItemAddedEvent):void
        {
            var _local_6:int;
            var _local_8:int;
            var _local_4:String;
            var _local_3:int;
            var _local_5:int;
            var _local_9:int;
            var _local_10:String;
            var _local_7:String;
            var _local_2:String;
            if (((!(_SafeStr_543 == null)) && (_SafeStr_543.productClassId == _arg_1.classId)))
            {
                if (_SafeStr_543.roomId == _roomEngine.activeRoomId)
                {
                    _local_6 = _arg_1.stripId;
                    _local_8 = _SafeStr_543.category;
                    _local_4 = _SafeStr_543.wallLocation;
                    _local_3 = _SafeStr_543.x;
                    _local_5 = _SafeStr_543.y;
                    _local_9 = _SafeStr_543.direction;
                    switch (_arg_1.category)
                    {
                        case 3:
                            _local_10 = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_floor_type");
                            if (_SafeStr_543.extraParameter != _local_10)
                            {
                                send(new RequestRoomPropertySet(_local_6));
                            };
                            break;
                        case 2:
                            _local_7 = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_wall_type");
                            if (_SafeStr_543.extraParameter != _local_7)
                            {
                                send(new RequestRoomPropertySet(_local_6));
                            };
                            break;
                        case 4:
                            _local_2 = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId, "room_landscape_type");
                            if (_SafeStr_543.extraParameter != _local_2)
                            {
                                send(new RequestRoomPropertySet(_local_6));
                            };
                            break;
                        default:
                            send(new PlaceObjectMessageComposer(_local_6, _local_8, _local_4, _local_3, _local_5, _local_9));
                    };
                    resetPlacedOfferData();
                };
            };
        }

        public function setImageFromAsset(_arg_1:IWindow, _arg_2:String, _arg_3:Function):void
        {
            if (((!(_arg_2)) || (!(assets))))
            {
                return;
            };
            var _local_4:BitmapDataAsset = (assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (_local_4 == null)
            {
                retrievePreviewAsset(_arg_2, _arg_3);
                return;
            };
            if (_arg_1)
            {
                HabboCatalog.setElementImageCentered(_arg_1, (_local_4.content as BitmapData));
            };
        }

        public function get imageGalleryHost():String
        {
            return (getProperty("image.library.catalogue.url"));
        }

        private function retrievePreviewAsset(_arg_1:String, _arg_2:Function):void
        {
            if (((!(_arg_1)) || (!(assets))))
            {
                return;
            };
            var _local_5:String = ((imageGalleryHost + _arg_1) + ".png");
            var _local_3:URLRequest = new URLRequest(_local_5);
            var _local_4:AssetLoaderStruct = assets.loadAssetFromFile(_arg_1, _local_3, "image/png");
            if (!_local_4)
            {
                return;
            };
            if (_arg_2 != null)
            {
                _local_4.addEventListener("AssetLoaderEventComplete", _arg_2);
            };
        }

        private function showMainWindow():void
        {
            var _local_1:IDesktopWindow;
            if ((((!(_windowManager == null)) && (!(_mainContainer == null))) && (_mainContainer.parent == null)))
            {
                _local_1 = _windowManager.getDesktop(1);
                if (_local_1 != null)
                {
                    _local_1.addChild(_mainContainer);
                };
            };
        }

        private function hideMainWindow():void
        {
            var _local_1:IDesktopWindow;
            if ((((!(_windowManager == null)) && (!(_mainContainer == null))) && (!(_mainContainer.parent == null))))
            {
                _local_1 = _windowManager.getDesktop(1);
                if (((!(_local_1 == null)) && (!(_SafeStr_544))))
                {
                    _local_1.removeChild(_mainContainer);
                    if (_SafeStr_528 != null)
                    {
                        _SafeStr_528.catalogWindowClosed();
                    };
                };
                _SafeStr_544 = false;
            };
        }

        private function mainWindowVisible():Boolean
        {
            return (((!(_windowManager == null)) && (!(_mainContainer == null))) && (!(_mainContainer.parent == null)));
        }

        public function update(_arg_1:uint):void
        {
            var _local_3:Number;
            var _local_2:Number;
            if (_SafeStr_515 != null)
            {
                _SafeStr_515.updatePreviewRoomView();
            };
            if ((getTimer() - _builderMembershipDisplayUpdateTime) > 500)
            {
                _local_3 = builderSecondsLeft;
                _local_2 = builderSecondsLeftWithGrace;
                if ((((_local_3 > -3) && (_local_3 < 200)) || ((_local_2 > -3) && (_local_2 < 200))))
                {
                    refreshBuilderStatus();
                };
            };
        }

        public function onGuildMemberships(_arg_1:GuildMembershipsMessageEvent):void
        {
            if (_SafeStr_521)
            {
                _SafeStr_521.onGuildMembershipsMessageEvent(_arg_1);
            };
        }

        private function onSnowWarGameTokenOffer(_arg_1:SnowWarGameTokensMessageEvent):void
        {
            var _local_3:SnowWarGameTokensMessageParser = _arg_1.getParser();
            disposeSnowWarTokens();
            for each (var _local_2:SnowWarGameTokenOffer in _local_3.offers)
            {
                if (_local_2.localizationId == "GET_SNOWWAR_TOKENS")
                {
                    _SafeStr_524 = new GameTokensOffer(_local_2.offerId, _local_2.localizationId, _local_2.priceInCredits, _local_2.priceInActivityPoints, _local_2.activityPointType);
                }
                else
                {
                    if (_local_2.localizationId == "GET_SNOWWAR_TOKENS2")
                    {
                        _SafeStr_525 = new GameTokensOffer(_local_2.offerId, _local_2.localizationId, _local_2.priceInCredits, _local_2.priceInActivityPoints, _local_2.activityPointType);
                    }
                    else
                    {
                        if (_local_2.localizationId == "GET_SNOWWAR_TOKENS3")
                        {
                            _SafeStr_526 = new GameTokensOffer(_local_2.offerId, _local_2.localizationId, _local_2.priceInCredits, _local_2.priceInActivityPoints, _local_2.activityPointType);
                        };
                    };
                };
            };
        }

        public function buySnowWarTokensOffer(_arg_1:String):void
        {
            if (((_arg_1 == "GET_SNOWWAR_TOKENS") && (_SafeStr_524)))
            {
                showPurchaseConfirmation(_SafeStr_524, -1, _SafeStr_524.localizationId);
            }
            else
            {
                if (((_arg_1 == "GET_SNOWWAR_TOKENS2") && (_SafeStr_525)))
                {
                    showPurchaseConfirmation(_SafeStr_525, -1, _SafeStr_525.localizationId);
                }
                else
                {
                    if (((_arg_1 == "GET_SNOWWAR_TOKENS3") && (_SafeStr_526)))
                    {
                        showPurchaseConfirmation(_SafeStr_526, -1, _SafeStr_526.localizationId);
                    }
                    else
                    {
                        _communication.connection.send(new GetSnowWarGameTokensOfferComposer());
                    };
                };
            };
        }

        public function verifyClubLevel(_arg_1:int=1):Boolean
        {
            if (_sessionDataManager.clubLevel >= _arg_1)
            {
                return (true);
            };
            openClubCenter();
            return (false);
        }

        public function openClubCenter():void
        {
            context.createLinkEvent("habboUI/open/hccenter");
        }

        public function openVault():void
        {
            context.createLinkEvent("habboUI/open/vault");
        }

        private function onGuildVisualSettingsChanged(_arg_1:GuildSettingsChangedInManageEvent):void
        {
            if (_SafeStr_521)
            {
                _SafeStr_521.onGuildVisualSettingsChanged(_arg_1.guildId);
            };
        }

        public function get avatarEditor():IHabboAvatarEditor
        {
            return (_avatarEditor);
        }

        public function checkGiftable(_arg_1:IPurchasableOffer):void
        {
            send(new GetIsOfferGiftableComposer(_arg_1.offerId));
        }

        public function rememberPageDuringVipPurchase(_arg_1:int):void
        {
            var _local_2:ICatalogNode = currentCatalogNavigator.getNodeById(_arg_1);
            if (_local_2)
            {
                _SafeStr_541 = _local_2.pageName;
            }
            else
            {
                _SafeStr_541 = "frontpage";
            };
        }

        public function forgetPageDuringVipPurchase():void
        {
            _SafeStr_541 = null;
            _SafeStr_544 = false;
        }

        public function doNotCloseAfterVipPurchase():void
        {
            _SafeStr_544 = (!(_SafeStr_541 == null));
        }

        private function initBundleDiscounts():void
        {
            sendGetBundleDiscountRuleset();
        }

        private function sendGetBundleDiscountRuleset():void
        {
            send(new _SafeStr_31());
        }

        public function sendGetProductOffer(_arg_1:int):void
        {
            send(new GetProductOfferComposer(_arg_1));
        }

        private function onBundleDiscountRulesetMessageEvent(_arg_1:BundleDiscountRulesetMessageEvent):void
        {
            var _local_2:BundleDiscountRulesetMessageParser = _arg_1.getParser();
            _bundleDiscountRuleset = _local_2.bundleDiscountRuleset;
            _utils.resolveBundleDiscountFlatPriceSteps();
        }

        private function onLimitedEditionSoldOut(_arg_1:LimitedEditionSoldOutEvent):void
        {
            _windowManager.alert("${catalog.alert.limited_edition_sold_out.title}", "${catalog.alert.limited_edition_sold_out.message}", 0, alertDialogEventProcessor);
            if (_SafeStr_516 != null)
            {
                _SafeStr_516.dispose();
                _SafeStr_516 = null;
            };
        }

        private function onProductOffer(_arg_1:ProductOfferEvent):void
        {
            var _local_6:IFurnitureData;
            var _local_3:ProductOfferMessageParser = _arg_1.getParser();
            var _local_4:CatalogPageMessageOfferData = _local_3.offerData;
            if (((!(_local_4)) || (_local_4.products.length == 0)))
            {
                return;
            };
            var _local_5:CatalogPageMessageProductData = _local_4.products[0];
            if (_local_5.uniqueLimitedItem)
            {
                _SafeStr_528.currentPage.updateLimitedItemsLeft(_local_4.offerId, _local_5.uniqueLimitedItemsLeft);
            };
            var _local_7:Vector.<IProduct> = new Vector.<IProduct>(0);
            var _local_8:IProductData = getProductData(_local_4.localizationId);
            for each (_local_5 in _local_4.products)
            {
                _local_6 = getFurnitureData(_local_5.furniClassId, _local_5.productType);
                _local_7.push(new Product(_local_5.productType, _local_5.furniClassId, _local_5.extraParam, _local_5.productCount, _local_8, _local_6, this, _local_5.uniqueLimitedItem, _local_5.uniqueLimitedItemSeriesSize, _local_5.uniqueLimitedItemsLeft));
            };
            var _local_2:Offer = new Offer(_local_4.offerId, _local_4.localizationId, _local_4.isRent, _local_4.priceInCredits, _local_4.priceInActivityPoints, _local_4.activityPointType, _local_4.giftable, _local_4.clubLevel, _local_7, _local_4.bundlePurchaseAllowed, this);
            if (!isOfferCompatibleWithCurrentMode(_local_2))
            {
                _local_2.dispose();
                return;
            };
            if (((_SafeStr_528) && (_SafeStr_528.currentPage)))
            {
                _local_2.page = _SafeStr_528.currentPage;
                _SafeStr_528.currentPage.dispatchWidgetEvent(new SelectProductEvent(_local_2));
                if (((_local_2.product) && (_local_2.product.productType == "i")))
                {
                    _SafeStr_528.currentPage.dispatchWidgetEvent(new SetExtraPurchaseParameterEvent(_local_2.product.extraParam));
                };
                if (((_SafeStr_539) && (_offerInFurniPlacing)))
                {
                    _offerInFurniPlacing = _local_2;
                };
            };
        }

        private function onBuildersClubSubscriptionStatus(_arg_1:BuildersClubSubscriptionStatusMessageEvent):void
        {
            var _local_2:BuildersClubSubscriptionStatusMessageParser = _arg_1.getParser();
            _builderFurniLimit = _local_2.furniLimit;
            _builderMaxFurniLimit = _local_2.maxFurniLimit;
            _SafeStr_545 = _local_2.secondsLeft;
            _builderMembershipUpdateTime = getTimer();
            _SafeStr_546 = _local_2.secondsLeftWithGrace;
            if (ExternalInterface.available)
            {
                ExternalInterface.call("FlashExternalInterface.updateBuildersClub", (_SafeStr_545 > 0));
            };
            if (currentPage != null)
            {
                currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
            };
            refreshBuilderStatus();
        }

        private function onBuildersClubFurniCount(_arg_1:BuildersClubFurniCountMessageEvent):void
        {
            _builderFurniCount = _arg_1.getParser().furniCount;
            if (currentPage != null)
            {
                currentPage.dispatchWidgetEvent(new CatalogWidgetBuilderSubscriptionUpdatedEvent());
            };
            refreshBuilderStatus();
        }

        private function refreshBuilderStatus():void
        {
            var _local_4:Number = (_SafeStr_545 - ((getTimer() - _builderMembershipUpdateTime) / 1000));
            var _local_2:Number = (_SafeStr_546 - ((getTimer() - _builderMembershipUpdateTime) / 1000));
            if ((((_SafeStr_547) && (_local_4 <= 0)) && (_local_2 > 0)))
            {
                events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_IN_GRACE"));
            }
            else
            {
                if (((_SafeStr_548) && (_local_2 <= 0)))
                {
                    events.dispatchEvent(new CatalogEvent("CATALOG_BUILDER_MEMBERSHIP_EXPIRED"));
                };
            };
            _SafeStr_547 = (_local_4 > 0);
            _SafeStr_548 = (_local_2 > 0);
            var _local_3:String = ("builder.header.status." + ((_SafeStr_547) ? "member" : ((_SafeStr_548) ? "grace" : "trial")));
            var _local_5:String = _localization.getLocalization(_local_3);
            _localization.registerParameter("builder.header.title", "bcstatus", _local_5);
            var _local_1:String = ((_SafeStr_547) ? FriendlyTime.getFriendlyTime(_localization, _local_4) : ((_SafeStr_548) ? FriendlyTime.getFriendlyTime(_localization, _local_2) : _local_5));
            _localization.registerParameter("builder.header.status.membership", "duration", (('<font color="#ff8d00"><b>' + _local_1) + "</b></font>"));
            _localization.registerParameter("builder.header.status.limit", "count", (('<font color="#ff8d00"><b>' + _builderFurniCount) + "</b></font>"));
            _localization.registerParameter("builder.header.status.limit", "limit", (('<font color="#ff8d00"><b>' + _builderFurniLimit) + "</b></font>"));
            _builderMembershipDisplayUpdateTime = getTimer();
        }

        public function get bundleDiscountEnabled():Boolean
        {
            return (!(_catalogType == "BUILDERS_CLUB"));
        }

        public function get bundleDiscountRuleset():BundleDiscountRuleset
        {
            return (_bundleDiscountRuleset);
        }

        public function get multiplePurchaseEnabled():Boolean
        {
            return ((getBoolean("catalog.multiple.purchase.enabled")) && (!(_catalogType == "BUILDERS_CLUB")));
        }

        public function get newAdditionsPageOpenDisabled():Boolean
        {
            return (getBoolean("catalog.new.additions.page.open.disabled"));
        }

        public function showVipBenefits():void
        {
            if (!_utils)
            {
                init();
            };
            if (_utils)
            {
                if (!getCatalogNavigator("NORMAL").initialized)
                {
                    refreshCatalogIndex("NORMAL");
                };
                _utils.showVipBenefits();
            };
        }

        public function get currentPage():ICatalogPage
        {
            return ((_SafeStr_528 == null) ? null : _SafeStr_528.currentPage);
        }

        public function displayProductIcon(_arg_1:String, _arg_2:int, _arg_3:IBitmapWrapperWindow):void
        {
            _utils.displayProductIcon(_arg_1, _arg_2, _arg_3);
        }

        public function openRentConfirmationWindow(_arg_1:IFurnitureData, _arg_2:Boolean, _arg_3:int=-1, _arg_4:int=-1, _arg_5:Boolean=false):void
        {
            if (_SafeStr_520 == null)
            {
                _SafeStr_520 = new RentConfirmationWindow(this);
            };
            _SafeStr_520.show(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function get roomSession():IRoomSession
        {
            return (_roomSession);
        }

        public function get linkPattern():String
        {
            return ("catalog/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "open":
                    if (_local_2.length > 2)
                    {
                        openCatalogPage(_local_2[2]);
                    }
                    else
                    {
                        openCatalog();
                    };
                    return;
                case "warehouse":
                    if (_local_2.length > 2)
                    {
                        openCatalogPage(_local_2[2], "BUILDERS_CLUB");
                    }
                    else
                    {
                        toggleCatalog("BUILDERS_CLUB", true);
                    };
                    return;
                case "club_buy":
                    openClubCenter();
                    return;
                default:
                    Logger.log(("Catalog unknown link-type receive: " + _local_2[1]));
                    return;
            };
        }

        public function get inventory():IHabboInventory
        {
            return (_inventory);
        }

        public function get mainContainer():IWindowContainer
        {
            return (_mainContainer);
        }

        public function toggleBuilderCatalog():void
        {
            toggleCatalog("BUILDERS_CLUB");
        }

        public function get catalogType():String
        {
            return (_catalogType);
        }

        public function getCatalogNavigator(_arg_1:String):ICatalogNavigator
        {
            return ((_catalogNavigators != null) ? _catalogNavigators[_arg_1] : null);
        }

        public function get currentCatalogNavigator():ICatalogNavigator
        {
            return (getCatalogNavigator(_catalogType));
        }

        public function get builderFurniLimit():int
        {
            return (_builderFurniLimit);
        }

        public function get builderFurniCount():int
        {
            return (_builderFurniCount);
        }

        public function get builderMaxFurniLimit():int
        {
            return (_builderMaxFurniLimit);
        }

        public function get builderSecondsLeft():Number
        {
            return (_SafeStr_545 - ((getTimer() - _builderMembershipUpdateTime) / 1000));
        }

        public function get builderSecondsLeftWithGrace():Number
        {
            return (_SafeStr_546 - ((getTimer() - _builderMembershipUpdateTime) / 1000));
        }

        public function get isDoorModeOverriddenInCurrentRoom():Boolean
        {
            var _local_3:int;
            var _local_1:IRoomObject;
            var _local_2:IRoomObject;
            if (((!(buildersClubEnabled)) || (builderSecondsLeft > 0)))
            {
                return (false);
            };
            var _local_4:int = roomEngine.getRoomObjectCount(roomSession.roomId, 10);
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _local_1 = roomEngine.getRoomObjectWithIndex(roomSession.roomId, _local_3, 10);
                if (FurniId.isBuilderClubId(_local_1.getId()))
                {
                    return (true);
                };
                _local_3++;
            };
            var _local_5:int = roomEngine.getRoomObjectCount(roomSession.roomId, 20);
            _local_3 = 0;
            while (_local_3 < _local_5)
            {
                _local_2 = roomEngine.getRoomObjectWithIndex(roomSession.roomId, _local_3, 20);
                if (FurniId.isBuilderClubId(_local_2.getId()))
                {
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }

        public function getOfferCenter(_arg_1:IOfferExtension):IOfferCenter
        {
            if (_offerCenter == null)
            {
                _offerCenter = new OfferCenter(windowManager, assets, this);
            };
            _offerCenter.offerExtension = _arg_1;
            return (_offerCenter);
        }

        public function isNewIdentity():Boolean
        {
            return (getInteger("new.identity", 0) > 0);
        }

        public function useNonTabbedCatalog():Boolean
        {
            return (getBoolean("client.desktop.use.non.tabbed.catalog"));
        }


    }
}