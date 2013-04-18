# NetService

This is a proof-of-concept for searching and listing net services (bonjour) on iOS.

## Get the sources

	git clone git@github.com:acoomans/NetBrowser.git
    cd NetBrowser
	git submodule update --init --recursive

## Usage

In a terminal, register the service:

    pip install -r Service/requirements.txt
    cd Service
    python service.py
    
Open _NetServiceBrowser.xcodeproj_ and run it.
Tap on _Browse_ and it should list the service in an alert view.
If you stop the service (CTRL-C in terminal), the alert view should pop up again.
