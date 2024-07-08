package com.fastbee.sip.server;

import javax.sip.*;
import javax.sip.header.CallIdHeader;
import javax.sip.message.Request;
import javax.sip.message.Response;
import java.util.TooManyListenersException;

public class NullSipProvider implements SipProvider {
    @Override
    public void addSipListener(SipListener sipListener) throws TooManyListenersException {

    }

    @Override
    public void removeSipListener(SipListener sipListener) {

    }

    @Override
    public SipStack getSipStack() {
        return null;
    }

    @Override
    public ListeningPoint getListeningPoint() {
        return null;
    }

    @Override
    public ListeningPoint[] getListeningPoints() {
        return new ListeningPoint[0];
    }

    @Override
    public void setListeningPoint(ListeningPoint listeningPoint) throws ObjectInUseException {

    }

    @Override
    public void addListeningPoint(ListeningPoint listeningPoint) throws ObjectInUseException, TransportAlreadySupportedException {

    }

    @Override
    public ListeningPoint getListeningPoint(String s) {
        return null;
    }

    @Override
    public void removeListeningPoint(ListeningPoint listeningPoint) throws ObjectInUseException {

    }

    @Override
    public CallIdHeader getNewCallId() {
        return null;
    }

    @Override
    public ClientTransaction getNewClientTransaction(Request request) throws TransactionUnavailableException {
        return null;
    }

    @Override
    public ServerTransaction getNewServerTransaction(Request request) throws TransactionAlreadyExistsException, TransactionUnavailableException {
        return null;
    }

    @Override
    public void sendRequest(Request request) throws SipException {

    }

    @Override
    public void sendResponse(Response response) throws SipException {

    }

    @Override
    public Dialog getNewDialog(Transaction transaction) throws SipException {
        return null;
    }

    @Override
    public void setAutomaticDialogSupportEnabled(boolean b) {

    }
}
