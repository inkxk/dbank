import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor Dbank {
	stable var currentValue: Float = 300;
	stable var startTime = Time.now();

	public query func checkBalance(): async Float {
		return currentValue;
	};

	public func topUp(amount: Float) {
		currentValue += amount;
		Debug.print(debug_show(currentValue));
	};

	public func withdraw(amount: Float) {
		let tempValue: Float = currentValue - amount;
		if (tempValue >= 0) {
			currentValue -= amount;
			Debug.print(debug_show(currentValue));
		} else {
			Debug.print("Amount too large, currentValue less than zero.");
		};
	};

	public func compound() {
		let currentTime = Time.now();
		let timeElapsedNS = currentTime - startTime;
		let timeElapsedS = timeElapsedNS / 1000000000;
		currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
		startTime := currentTime;
	}
};
