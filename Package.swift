// swift-tools-version:5.6

import PackageDescription

let package = Package(
	name: "protobuf",
	platforms: [
		.iOS(.v12),
		.macOS(.v10_13),
		.macCatalyst(.v13),
		.watchOS(.v5),
		.tvOS(.v11)
	],
	products: [
		.library(
			name: "libprotobuf",
			targets: [
				"protobuf",
			]),
		.library(
			name: "dylibprotobuf",
			type: .dynamic,
			targets: [
				"protobuf",
			]),
		.library(
			name: "libprotobuf-lite",
			type: .static,
			targets: [
				"protobuf_lite",
			]),
		.library(
			name: "dylibprotobuf-lite",
			type: .dynamic,
			targets: [
				"protobuf_lite",
			]),
		.executable(name: "protoc", targets: ["protoc", "libprotoc"])
	],
	dependencies: [
		.package(url: "git@github.corp.ebay.com:eBayMobile/abseil-cpp.git", branch: "ebay/release"),
		.package(url: "git@github.corp.ebay.com:eBayMobile/jsoncpp.git", branch: "ebay/release"),
		.package(url: "git@github.corp.ebay.com:eBayMobile/utf8_range.git", branch: "ebay/release"),
		.package(url: "git@github.corp.ebay.com:eBayMobile/googletest.git", branch: "ebay/release"),
	],
	targets: [
		.executableTarget(
			name: "protoc",
			dependencies: [
				"libprotoc",
			],
			path: "src",
			sources: [
				"google/protobuf/compiler/main.cc",
			],
			cSettings: [
				.headerSearchPath(".")
			]
		),
		.target(
			name: "libprotoc",
			dependencies: [
				.product(name: "libabsl", package: "abseil-cpp"),
				.product(name: "libjsoncpp", package: "jsoncpp"),
				.product(name: "utf8_validity", package: "utf8_range"),
				"protobuf",
			],
			path: "./",
			sources: [
				"src/google/protobuf/compiler/allowlists/empty_package.cc",
				"src/google/protobuf/compiler/allowlists/weak_imports.cc",
				"src/google/protobuf/compiler/code_generator.cc",
				"src/google/protobuf/compiler/command_line_interface.cc",
				"src/google/protobuf/compiler/cpp/enum.cc",
				"src/google/protobuf/compiler/cpp/extension.cc",
				"src/google/protobuf/compiler/cpp/field.cc",
				"src/google/protobuf/compiler/cpp/field_generators/cord_field.cc",
				"src/google/protobuf/compiler/cpp/field_generators/enum_field.cc",
				"src/google/protobuf/compiler/cpp/field_generators/map_field.cc",
				"src/google/protobuf/compiler/cpp/field_generators/message_field.cc",
				"src/google/protobuf/compiler/cpp/field_generators/primitive_field.cc",
				"src/google/protobuf/compiler/cpp/field_generators/string_field.cc",
				"src/google/protobuf/compiler/cpp/file.cc",
				"src/google/protobuf/compiler/cpp/generator.cc",
				"src/google/protobuf/compiler/cpp/helpers.cc",
				"src/google/protobuf/compiler/cpp/message.cc",
				"src/google/protobuf/compiler/cpp/padding_optimizer.cc",
				"src/google/protobuf/compiler/cpp/parse_function_generator.cc",
				"src/google/protobuf/compiler/cpp/service.cc",
				"src/google/protobuf/compiler/cpp/tracker.cc",
				"src/google/protobuf/compiler/csharp/csharp_doc_comment.cc",
				"src/google/protobuf/compiler/csharp/csharp_enum.cc",
				"src/google/protobuf/compiler/csharp/csharp_enum_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_field_base.cc",
				"src/google/protobuf/compiler/csharp/csharp_generator.cc",
				"src/google/protobuf/compiler/csharp/csharp_helpers.cc",
				"src/google/protobuf/compiler/csharp/csharp_map_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_message.cc",
				"src/google/protobuf/compiler/csharp/csharp_message_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_primitive_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_reflection_class.cc",
				"src/google/protobuf/compiler/csharp/csharp_repeated_enum_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_repeated_message_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_repeated_primitive_field.cc",
				"src/google/protobuf/compiler/csharp/csharp_source_generator_base.cc",
				"src/google/protobuf/compiler/csharp/csharp_wrapper_field.cc",
				"src/google/protobuf/compiler/csharp/names.cc",
				"src/google/protobuf/compiler/java/context.cc",
				"src/google/protobuf/compiler/java/doc_comment.cc",
				"src/google/protobuf/compiler/java/enum.cc",
				"src/google/protobuf/compiler/java/enum_field.cc",
				"src/google/protobuf/compiler/java/enum_field_lite.cc",
				"src/google/protobuf/compiler/java/enum_lite.cc",
				"src/google/protobuf/compiler/java/extension.cc",
				"src/google/protobuf/compiler/java/extension_lite.cc",
				"src/google/protobuf/compiler/java/field.cc",
				"src/google/protobuf/compiler/java/file.cc",
				"src/google/protobuf/compiler/java/generator.cc",
				"src/google/protobuf/compiler/java/generator_factory.cc",
				"src/google/protobuf/compiler/java/helpers.cc",
				"src/google/protobuf/compiler/java/kotlin_generator.cc",
				"src/google/protobuf/compiler/java/map_field.cc",
				"src/google/protobuf/compiler/java/map_field_lite.cc",
				"src/google/protobuf/compiler/java/message.cc",
				"src/google/protobuf/compiler/java/message_builder.cc",
				"src/google/protobuf/compiler/java/message_builder_lite.cc",
				"src/google/protobuf/compiler/java/message_field.cc",
				"src/google/protobuf/compiler/java/message_field_lite.cc",
				"src/google/protobuf/compiler/java/message_lite.cc",
				"src/google/protobuf/compiler/java/message_serialization.cc",
				"src/google/protobuf/compiler/java/name_resolver.cc",
				"src/google/protobuf/compiler/java/names.cc",
				"src/google/protobuf/compiler/java/primitive_field.cc",
				"src/google/protobuf/compiler/java/primitive_field_lite.cc",
				"src/google/protobuf/compiler/java/service.cc",
				"src/google/protobuf/compiler/java/shared_code_generator.cc",
				"src/google/protobuf/compiler/java/string_field.cc",
				"src/google/protobuf/compiler/java/string_field_lite.cc",
				"src/google/protobuf/compiler/objectivec/enum.cc",
				"src/google/protobuf/compiler/objectivec/enum_field.cc",
				"src/google/protobuf/compiler/objectivec/extension.cc",
				"src/google/protobuf/compiler/objectivec/field.cc",
				"src/google/protobuf/compiler/objectivec/file.cc",
				"src/google/protobuf/compiler/objectivec/generator.cc",
				"src/google/protobuf/compiler/objectivec/helpers.cc",
				"src/google/protobuf/compiler/objectivec/import_writer.cc",
				"src/google/protobuf/compiler/objectivec/line_consumer.cc",
				"src/google/protobuf/compiler/objectivec/map_field.cc",
				"src/google/protobuf/compiler/objectivec/message.cc",
				"src/google/protobuf/compiler/objectivec/message_field.cc",
				"src/google/protobuf/compiler/objectivec/names.cc",
				"src/google/protobuf/compiler/objectivec/oneof.cc",
				"src/google/protobuf/compiler/objectivec/primitive_field.cc",
				"src/google/protobuf/compiler/objectivec/text_format_decode_data.cc",
				"src/google/protobuf/compiler/php/names.cc",
				"src/google/protobuf/compiler/php/php_generator.cc",
				"src/google/protobuf/compiler/plugin.cc",
				"src/google/protobuf/compiler/plugin.pb.cc",
				"src/google/protobuf/compiler/python/generator.cc",
				"src/google/protobuf/compiler/python/helpers.cc",
				"src/google/protobuf/compiler/python/pyi_generator.cc",
				"src/google/protobuf/compiler/retention.cc",
				"src/google/protobuf/compiler/ruby/ruby_generator.cc",
				"src/google/protobuf/compiler/rust/accessors/accessors.cc",
				"src/google/protobuf/compiler/rust/accessors/singular_bytes.cc",
				"src/google/protobuf/compiler/rust/accessors/singular_scalar.cc",
				"src/google/protobuf/compiler/rust/context.cc",
				"src/google/protobuf/compiler/rust/generator.cc",
				"src/google/protobuf/compiler/rust/message.cc",
				"src/google/protobuf/compiler/rust/naming.cc",
				"src/google/protobuf/compiler/subprocess.cc",
				"src/google/protobuf/compiler/zip_writer.cc",
			],
			publicHeadersPath: "libprotoc_hdrs",
			linkerSettings: [
				.linkedLibrary("z")
			]
		),
		.target(
			name: "protobuf_lite",
			dependencies: [
				.product(name: "libabsl", package: "abseil-cpp"),
				.product(name: "libjsoncpp", package: "jsoncpp"),
				.product(name: "utf8_validity", package: "utf8_range"),
			],
			path: "./",
			sources: [
				"src/google/protobuf/any_lite.cc",
				"src/google/protobuf/arena.cc",
				"src/google/protobuf/arena_align.cc",
				"src/google/protobuf/arena_config.cc",
				"src/google/protobuf/arenastring.cc",
				"src/google/protobuf/arenaz_sampler.cc",
				"src/google/protobuf/extension_set.cc",
				"src/google/protobuf/generated_enum_util.cc",
				"src/google/protobuf/generated_message_tctable_lite.cc",
				"src/google/protobuf/generated_message_util.cc",
				"src/google/protobuf/implicit_weak_message.cc",
				"src/google/protobuf/inlined_string_field.cc",
				"src/google/protobuf/io/coded_stream.cc",
				"src/google/protobuf/io/io_win32.cc",
				"src/google/protobuf/io/zero_copy_stream.cc",
				"src/google/protobuf/io/zero_copy_stream_impl.cc",
				"src/google/protobuf/io/zero_copy_stream_impl_lite.cc",
				"src/google/protobuf/map.cc",
				"src/google/protobuf/message_lite.cc",
				"src/google/protobuf/parse_context.cc",
				"src/google/protobuf/port.cc",
				"src/google/protobuf/repeated_field.cc",
				"src/google/protobuf/repeated_ptr_field.cc",
				"src/google/protobuf/stubs/common.cc",
				"src/google/protobuf/wire_format_lite.cc",
			],
			publicHeadersPath: "include_lite",
			linkerSettings: [
				.linkedLibrary("z")
			]
		),
		.target(
			name: "protobuf",
			dependencies: [
				.product(name: "libabsl", package: "abseil-cpp"),
				.product(name: "libjsoncpp", package: "jsoncpp"),
				.product(name: "utf8_validity", package: "utf8_range"),
				"protobuf_lite",
			],
			path: "./",
			sources: [
				"src/google/protobuf/any.pb.cc",
				"src/google/protobuf/api.pb.cc",
				"src/google/protobuf/duration.pb.cc",
				"src/google/protobuf/empty.pb.cc",
				"src/google/protobuf/field_mask.pb.cc",
				"src/google/protobuf/source_context.pb.cc",
				"src/google/protobuf/struct.pb.cc",
				"src/google/protobuf/timestamp.pb.cc",
				"src/google/protobuf/type.pb.cc",
				"src/google/protobuf/wrappers.pb.cc",
				"src/google/protobuf/any.cc",
				"src/google/protobuf/compiler/importer.cc",
				"src/google/protobuf/compiler/parser.cc",
				"src/google/protobuf/descriptor.cc",
				"src/google/protobuf/descriptor.pb.cc",
				"src/google/protobuf/descriptor_database.cc",
				"src/google/protobuf/dynamic_message.cc",
				"src/google/protobuf/extension_set_heavy.cc",
				"src/google/protobuf/generated_message_bases.cc",
				"src/google/protobuf/generated_message_reflection.cc",
				"src/google/protobuf/generated_message_tctable_full.cc",
				"src/google/protobuf/generated_message_tctable_gen.cc",
				"src/google/protobuf/io/gzip_stream.cc",
				"src/google/protobuf/io/printer.cc",
				"src/google/protobuf/io/strtod.cc",
				"src/google/protobuf/io/tokenizer.cc",
				"src/google/protobuf/io/zero_copy_sink.cc",
				"src/google/protobuf/json/internal/lexer.cc",
				"src/google/protobuf/json/internal/message_path.cc",
				"src/google/protobuf/json/internal/parser.cc",
				"src/google/protobuf/json/internal/unparser.cc",
				"src/google/protobuf/json/internal/untyped_message.cc",
				"src/google/protobuf/json/internal/writer.cc",
				"src/google/protobuf/json/internal/zero_copy_buffered_stream.cc",
				"src/google/protobuf/json/json.cc",
				"src/google/protobuf/map_field.cc",
				"src/google/protobuf/message.cc",
				"src/google/protobuf/reflection_mode.cc",
				"src/google/protobuf/reflection_ops.cc",
				"src/google/protobuf/service.cc",
				"src/google/protobuf/text_format.cc",
				"src/google/protobuf/unknown_field_set.cc",
				"src/google/protobuf/util/delimited_message_util.cc",
				"src/google/protobuf/util/field_comparator.cc",
				"src/google/protobuf/util/field_mask_util.cc",
				"src/google/protobuf/util/message_differencer.cc",
				"src/google/protobuf/util/time_util.cc",
				"src/google/protobuf/util/type_resolver_util.cc",
				"src/google/protobuf/wire_format.cc",
			],
			publicHeadersPath: "include",
			cSettings: [
				.define("HAVE_ZLIB")
			],
			linkerSettings: [
				.linkedLibrary("z")
			]
		),
		.testTarget(
			name: "common_tests",
			dependencies: [
				"libprotoc",
				.product(name: "googletest", package: "googletest"),
				.product(name: "googlemock", package: "googletest"),
			],
			path: "src",
			sources: [
				"google/protobuf/compiler/mock_code_generator.cc",
				"google/protobuf/testing/file.cc",
				"google/protobuf/testing/googletest.cc",
			],
			cSettings: [
				.headerSearchPath(".")
			]
		)
	],
	cLanguageStandard: .gnu11,
	cxxLanguageStandard: .gnucxx20
)
