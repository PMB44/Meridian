import CoreText
import Foundation

/// Registers the bundled fonts at launch, so no Info.plist font list is needed.
enum FontRegistrar {
    /// Registers every `Typeface`. Returns the names that could not be registered.
    @discardableResult
    static func registerAll(in bundle: Bundle = .main) -> [String] {
        var failed: [String] = []
        for face in Typeface.allCases {
            guard let url = bundle.url(forResource: face.rawValue, withExtension: "ttf") else {
                failed.append(face.rawValue)
                continue
            }
            var error: Unmanaged<CFError>?
            let registered = CTFontManagerRegisterFontsForURL(url as CFURL, .process, &error)
            if !registered {
                let code = error.map { CFErrorGetCode($0.takeRetainedValue()) }
                if code != CTFontManagerError.alreadyRegistered.rawValue {
                    failed.append(face.rawValue)
                }
            }
        }
        return failed
    }
}
